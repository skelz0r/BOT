class Austisme
  def initialize(event, last_autisme, last_victim)
    @tence = SyllabeExtractor.new(event.message)
    @sentence = @tence.perform

    @event = event
    @last_autisme = last_autisme
    @last_victim = last_victim
  end

  def mad?
    (rand(autisme_rand) == 0 || ( @last_autisme && @sentence == @last_autisme.say && @last_victime != @event.user.nick))
  end

  def madness!
    @speeque = SentenceToSoundSample.new(@sentence)
    @speeque.perform
  end

  def say
    @sentence
  end

  def sound_url
    @speeque.url
  end

  private

  def autism_rand
    ENV['AUTISM_RAND']
  end
end
