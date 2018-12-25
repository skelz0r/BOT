$:.unshift File.dirname(__FILE__)
require 'cinch'
require 'uri'

require 'lib/tor'
require 'lib/speeque'
require 'lib/schizophrenic'

if ENV["DEBUG"]
  NICK = "BOTDEBUG"
  CHANS = ["#autisme"]
  RAND = 1
else
  NICK = "BOT"
  CHANS = [
    "#balemboy", 
    "#carambar",
    "#1A", 
    "#cesoir", 
    "#rage",
  ]
  RAND = 30
end

class Austisme
  def initialize(event, last_autisme, last_victim)
    @tence = Tor.new(event.message)
    @sentence = @tence.final_sentence

    @event = event
    @last_autisme = last_autisme
    @last_victim = last_victim
  end

  def mad?
    (rand(RAND) == 0 || ( @last_autisme && @sentence == @last_autisme.say && @last_victime != @event.user.nick))
  end

  def madness!
    @speeque = Speeque.new(@sentence)
    @speeque.tolque
  end

  def say
    @sentence
  end

  def sound_url
    @speeque.url
  end

  def sound_path
    @speeque.path
  end
end

bot = Cinch::Bot.new do
  configure do |c|
    c.nick = NICK
    c.user = "BOT"
    c.server = "irc.iiens.net"
    c.channels = CHANS
  end

  on :message, /.*/ do |m|
    if m.message =~ /^\s*OKI\s*\?\s*$/ && ((m.user.nick == 'Skelz0r' || m.user.nick == 'feriel' || m.user.nick == 'Kiddo') || rand(5) == 1)
      m.reply "OKI"
      return
    end

    if m.message == 'SRLY BOT ?'
      m.reply [
        'Oui',
        'Non',
        'Je ne sais pas',
        'TG',
        'SLRY* stp',
        'On se clame au fond svp merci',
      ].sample
      return
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

    if m.message =~ /eoh\s*$/
      if rand(100) == 1
        m.reply 'TG Amora'
        return
      end

      m.reply [
        'On se clap au fond svp',
        'On se corn au fond svp',
        'On se clame au fond svp',
        'On se klam au fond svp',
        'On se clape au fond svp',
        'On se skelz0r au fond svp',
        'On se thurolf au fond svp',
        'Ça coinche au fond svp',
        'C\'est coinché au fond svp',
        'On se stuff au fond svp',
        'On se ghost au fond svp',
        'On se profile au fond svp',
        'On se pakito au fond svp',
        'On se guinness dans le hall svp',
        'On picole au fond svp',
        'On s\'égare au fond svp',
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
