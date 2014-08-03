require 'cinch'
require 'text/hyphen'
require 'tts'

if ENV["DEBUG"]
  p "DEBUG"
  NICK = "BOTDEBUG"
  CHANS = ["#autisme"]
  RAND = 1
else
  NICK = "BOT"
  CHANS = ["#balemboy", "#agora"]
  RAND = 20
end

SOUND_PATH = "sounds/"
URL_SOUND = "http://BOT.skelz0r.fr/"

class Austisme
  def initialize(sentence)
    @hh = Text::Hyphen.new(language: 'fr')
    @points = @hh.hyphenate(sentence)
    @sentence = sentence
  end

  def say
    final_sentence
  end

  def generate_sound(options={with_url: false})
    file_name = path_to_file(final_sentence)
    final_sentence.downcase.to_file "fr", SOUND_PATH + file_name
    options[:with_url] ? URL_SOUND + file_name : SOUND_PATH + file_name
  end

  protected

  def final_sentence
    @final_sentence ||= begin
      index = @points[-1]
      truncate_sentence = @points.empty? ? @sentence : @sentence[index..-1]
      upcase(sanitize_punctuation(truncate_sentence))
    end
  end

  def path_to_file(sentence)
    file = "#{sentence}.MP3"
    File.delete(SOUND_PATH + file) if File.exists?(SOUND_PATH + file)
    file
  end

  def sanitize_punctuation(sentence)
    sentence.gsub(/ +[^\w\s]*$/, "").gsub(/ *<3/, "").gsub("*", "")
  end

  def upcase(string)
    string.upcase.gsub(/[æøåäâãàáëêèéïîìíöôõòóüûùúý]/){|s| (s.ord-32).chr(Encoding::UTF_8)}
  end
end

if ENV["LOCAL"]
  p Austisme.new(ARGV[0]).say
  p Austisme.new(ARGV[0]).generate_sound
  p Austisme.new(ARGV[0]).generate_sound(with_url: true)
else
  bot = Cinch::Bot.new do
    configure do |c|
      c.nick = NICK
      c.user = "SER"
      c.server = "irc.iiens.net"
      c.channels = CHANS
    end

    on :message, /.*/ do |m|
      begin
        autisme = Austisme.new(m.message)
        m.reply (Format(:bold, "#{autisme.say}") + " " + Format(:black, "#{autisme.generate_sound(with_url: true)}")) if rand(RAND) == 0
      rescue
        m.reply "DOH"
      end
    end
  end

  bot.start
end
