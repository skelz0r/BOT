# frozen_string_literal: true

require 'text/hyphen'

class SyllabeExtractor
  def initialize(sentence)
    @hh = Text::Hyphen.new(language: 'fr')
    @points = @hh.hyphenate(sentence)
    @sentence = sentence
  end

  # rubocop:disable Style/RescueStandardError
  def perform
    index = @points[-1]
    truncate_sentence = @points.empty? ? @sentence : @sentence[index..-1]
    upcase(sanitize_punctuation(truncate_sentence))
  rescue => e
    p e
    random_sentence
  end
  # rubocop:enable Style/RescueStandardError

  protected

  def upcase(string)
    string.upcase.gsub(/[æøåäâãàáëêèéïîìíöôõòóüûùúý]/) { |s| (s.ord - 32).chr(Encoding::UTF_8) }
  end

  def sanitize_punctuation(sentence)
    sentence.gsub(/ +[^\w\s]*$/, '').gsub(/ *<3/, '').gsub('*', '')
  end

  def random_sentence
    %w[
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
    ]
  end
end
