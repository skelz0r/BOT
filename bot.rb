# frozen_string_literal: true

$LOAD_PATH.unshift File.dirname(__FILE__)

require 'cinch'
require 'uri'
require 'spintax_parser'

require 'lib/interceptor/base_interceptor'

class String
  include SpintaxParser
end

[
  'lib/',
  'lib/interceptor/',
].each do |path|
  Dir.entries(path).each do |file|
    next unless file =~ /\.rb$/

    require "#{path}#{file.gsub(/\.rb$/, '')}"
  end
end

@last_autisme = nil

if ENV['DEBUG']
  ENV['BOT_NICK'] ||= 'BOTDEBUG'

  CHANS = [
    '#autisme',
  ].freeze

  ENV['AUTISME_RAND'] ||= '1'
else
  ENV['BOT_NICK'] ||= 'BOT'

  CHANS = [
    '#balemboy',
    '#carambar',
    '#1A',
    '#cesoir',
    '#rage',
  ].freeze

  ENV['AUTISME_RAND'] ||= '30'
end

interceptors = [
  OkiInterceptor,
  LolInterceptor,
  EohInterceptor,
  BalembotSrlyInterceptor,
  FridayInterceptor,
  KeywordToSentenceInterceptor,
  Stalz0rInterceptor,
]

bot = Cinch::Bot.new do
  configure do |c|
    c.nick = ENV['BOT_NICK']
    c.user = 'BOT'
    c.server = 'irc.iiens.net'
    c.channels = CHANS
  end

  on :invite do |m|
    @bot.join(m.channel)
  end

  on :message, /.*/ do |m|
    interceptors.each do |interceptor_klass|
      interceptor = interceptor_klass.new(m.message, m.user)

      # rubocop:disable Style/Next
      if interceptor.match?
        m.reply interceptor.reply.unspin

        return true
      end
      # rubocop:enable Style/Next
    end

    autisme = Austisme.new(m.message, @last_autisme)

    if autisme.mad?
      autisme.madness!

      m.reply("#{Format(:bold, autisme.sentence)} #{Format(:black, autisme.sound_url)}")

      @last_autisme = autisme
    end
  end
end

bot.start
