require 'cinch'
require 'text/hyphen'
require 'tts'
require 'uri'
require 'ruby-sox'

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

SOUND_PATH = "/var/www/bot/"
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
    final_sentence.downcase.to_file "fr", (SOUND_PATH + file_name + ".tmp.mp3")
    modulate_sound(SOUND_PATH + file_name)
    options[:with_url] ? URI.escape(URL_SOUND + file_name) : SOUND_PATH + file_name
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
    file = "#{sentence}#{sound_options_stringify}.MP3"
    File.delete(SOUND_PATH + file) if File.exists?(SOUND_PATH + file)
    file
  end

  def modulate_sound(file)
    tmp_file = file+".tmp.mp3"
    sox = Sox::Cmd.new
          .add_input(tmp_file)
          .set_output(file)
          .set_effects(sound_options)
    sox.run
    File.delete(tmp_file)
  end

  def sound_options
    @sound_options ||= { pitch: rand(-1300..1300), speed: rand(0.7..1.2) }
  end

  def sound_options_stringify
    "-#{sound_options[:pitch].to_s}-#{sound_options[:speed].to_s.sub(".", "-")}"
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
  aut = Austisme.new(ARGV[0])
  p aut.generate_sound
  p aut.generate_sound(with_url: true)
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
