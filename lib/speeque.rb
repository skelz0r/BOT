require 'espeak'
require 'ruby-sox'

class Speeque
  include ESpeak

  SOUND_PATH = "./sounds/"
  URL_SOUND = "HTTP://BOT.SKELZ0R.FR/"

  def initialize(sentence)
    @sentence = sentence
  end

  def tolque
    @file_name = path_to_file(@sentence)
    speech = Speech.new(@sentence, voice: "fr")
    speech.save(SOUND_PATH + @file_name + ".tmp.mp3")
    modulate_sound(SOUND_PATH + @file_name)
  end

  def path
    SOUND_PATH + @file_name
  end

  def url
    URI.escape(URL_SOUND + @file_name)
  end

  protected

  def path_to_file(sentence)
    "#{sentence}#{sound_options_stringify}.MP3"
  end

  def modulate_sound(file)
    tmp_file = file+".tmp.mp3"

    sox = Sox::Cmd.new.add_input(tmp_file)
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
end
