$:.unshift File.dirname(__FILE__)
require 'cinch'
require 'uri'

require 'lib/tor'
require 'lib/speeque'

if ENV["DEBUG"]
  p "DEBUG"
  NICK = "BOTDEBUG"
  CHANS = ["#autisme"]
  RAND = 1
else
  NICK = "BOT"
  CHANS = ["#balemboy", "#1A", "#cesoir", "#rage"]
  RAND = 50
end

class Austisme
  def initialize(event, last_autisme, last_victim)
    @tence = Tor.new(event.message) #.final_sentence

    @event = event
    @last_autisme = last_autisme
    @last_victim = last_victim
  end

  def mad?
    (rand(RAND) == 0 || (autisme.say == @last_autisme && @last_victime != @event.user.nick))
  end

  def monster_mad?
    rand(5) == 0
  end

  def madness!
    @sentence = @tence.final_sentence

    @speeque = Speeque.new(@sentence)
    @speeque.tolque
  end

  def schizophrenic!

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
    autisme = Austisme.new(m, @last_autisme, @last_victim)

    if autisme.mad?
      autisme.madness!

      # if autisme.monster_mad?
      # else
        m.reply (Format(:bold, "#{autisme.say}") + " " + Format(:black, "#{autisme.sound_url}"))
      # end

      @last_victim = m.user.nick
      @last_autisme = autisme
    end
  end
end

bot.start
