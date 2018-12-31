class Austisme
  attr_reader :sentence,
    :initial_message,
    :last_autisme,
    :sound_url

  def initialize(message, last_autisme)
    @initial_message = message
    @sentence = SyllabeExtractor.new(message).perform
    @last_autisme = last_autisme
  end

  def mad?
    rand(autisme_rand) == 0 ||
      same_sentence_from_last_autisme?
  end

  def madness!
    sentence_to_sound_sample = SentenceToSoundSample.new(sentence)

    sentence_to_sound_sample.perform
    @sound_url = sentence_to_sound_sample.url
  end

  private

  def same_sentence_from_last_autisme?
    last_autisme && sentence == last_autisme.say
  end

  def autisme_rand
    if initial_message.upcase == initial_message
      (ENV['AUTISME_RAND'].to_i) / 2
    else
      (ENV['AUTISME_RAND'].to_i)
    end
  end
end
