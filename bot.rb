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

  RAND = 1
else
  NICK = ENV['NICK'] || "BOT"

  CHANS = [
    "#balemboy",
    "#carambar",
    "#1A",
    "#cesoir",
    "#rage",
  ]

  RAND = 30
end

interceptors = [
  OkiInterceptor,
  EohInterceptor,
  BalembotSrlyInterceptor,
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

    if m.message == 'DES PUTES'
      m.reply [
        'ET DU FROMAGE',
      ].sample
      return
    end

    if m.message == 'KIKI'
      m.reply [
        'DO U LUV ME',
      ].sample
      return
    end

    if m.message =~ /\s*T A R T I\s*$/
      m.reply "F L E X"
      return
    end

    if m.message =~ /\s*TARTI\s*$/
      m.reply "FLEX"
      return
    end

    if m.message =~ /\s*PRINCESS\s*$/
      m.reply "RACLETTE"
      return
    end

    if m.message =~ /\s*RA\s*$/
      m.reply "CLETTE"
      return
    end

    if m.message =~ /\s*PRNCSS\s*$/
      m.reply "RCLTT"
      return
    end

    if m.message =~ /\s*RINCESS\s*$/
      m.reply "ACLETTE"
      return
    end

    if m.message =~ /\s*CORN\s*$/
      m.reply [
        "FLAKES",
        "FLEX",
      ].sample
      return
    end

    if m.message =~ /\s*CRN\s*$/
      m.reply [
        "FLKS",
        "FLX",
      ].sample
      return
    end

    if m.message =~ /\s*MARTIN\s*$/
      m.reply [
        "MYSTERE",
        "FLEX",
      ].sample
      return
    end

    if m.message =~ /\s*ARTIN\s*$/
      m.reply [
        "YSTERE",
        "LEX",
      ].sample
      return
    end

    if m.message =~ /\s*MRTN\s*$/
      m.reply [
        "MSTR",
        "FLX",
      ].sample
      return
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
