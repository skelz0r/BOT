require 'ruby-sox'

class Schizophrenic
  SOUND_PATH = "/var/www/bot/"
  URL_SOUND = "http://BOT.skelz0r.fr/"

  def initialize(autisme1, autisme2)
    @autisme1 = autisme1
    @autisme2 = autisme2
  end

  def OVER_NINE_THOUSAND
    @file_name = generate_filename
    combiner = Sox::Combiner.new([@autisme1.sound_path, @autisme2.sound_path], :combine => :concatenate)
    combiner.write(self.path)
  end

  def sentence
    @autisme1.say + @autisme2.say
  end

  def path
    SOUND_PATH + @file_name
  end

  def url
    URI.escape(URL_SOUND + @file_name)
  end

  protected

  def generate_filename
    "#{sentence}-#{rand(9999).to_s}.mp3"
  end
end
