$:.unshift File.dirname(__FILE__)

require 'cinch'
require 'uri'

require 'lib/interceptor/base_interceptor'

[
  'lib/',
  'lib/interceptor/',
].each do |path|
  Dir.entries(path).each do |file|
    next unless file =~ /\.rb$/

    require "#{path}#{file.gsub(/\.rb$/, '')}"
  end
end

if ENV["DEBUG"]
  NICK = "BOTDEBUG"

  CHANS = [
    "#autisme",
  ]

  ENV['AUTISM_RAND'] = 1
else
  NICK = ENV['NICK'] || "BOT"

  CHANS = [
    "#balemboy",
    "#carambar",
    "#1A",
    "#cesoir",
    "#rage",
  ]

  ENV['AUTISM_RAND'] = 30
end

interceptors = [
  OkiInterceptor,
  EohInterceptor,
  BalembotSrlyInterceptor,
  KeywordToSentenceInterceptor,
]

bot = Cinch::Bot.new do
  configure do |c|
    c.nick = NICK
    c.user = "BOT"
    c.server = "irc.iiens.net"
    c.channels = CHANS
  end

  on :message, /.*/ do |m|
    interceptors.each do |interceptor_klass|
      interceptor = interceptor_klass.new(m.message, m.user)

      if interceptor.match?
        m.reply interceptor.reply
        return
      end
    end

    autisme = Austisme.new(m, @last_autisme, @last_victim)

    if autisme.mad?
      autisme.madness!

      m.reply (Format(:bold, "#{autisme.say}") + " " + Format(:black, "#{autisme.sound_url}"))

      @last_victim = m.user.nick
      @last_autisme = autisme
    end
  end
end

bot.start
