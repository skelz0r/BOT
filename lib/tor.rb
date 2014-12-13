require 'text/hyphen'

# SentenceExtractor => Tor
class Tor
  RANDOM_TEXT = %w(
    FU
    BA
    YOP
    PING
    CLA
    CI
    TA
    YA
    VIN
    GIN
    SEXE
    CLOPE
    RHUM
  )

  def initialize(sentence)
    @hh = Text::Hyphen.new(language: 'fr')
    @points = @hh.hyphenate(sentence)
    @sentence = sentence
  end

  def final_sentence
    @final_sentence ||= begin
      index = @points[-1]
      truncate_sentence = @points.empty? ? @sentence : @sentence[index..-1]
      upcase(sanitize_punctuation(truncate_sentence))
    rescue => e
      p e
      RANDOM_TEXT.sample
    end
  end

  protected

  def upcase(string)
    string.upcase.gsub(/[æøåäâãàáëêèéïîìíöôõòóüûùúý]/){|s| (s.ord-32).chr(Encoding::UTF_8)}
  end

  def sanitize_punctuation(sentence)
    sentence.gsub(/ +[^\w\s]*$/, "").gsub(/ *<3/, "").gsub("*", "")
  end
end
