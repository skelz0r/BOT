require 'yaml'

class KeywordToSentenceInterceptor < BaseInterceptor
  def match?
    keywords.any? do |keyword|
      matching_pattern?(keyword)
    end
  end

  def reply
    valid_keyword = keywords.find do |keyword|
      matching_pattern?(keyword)
    end

    sentence = backend[valid_keyword].sample

    if splitted_text?(valid_keyword)
      split_text(sentence)
    else
      sentence
    end
  end

  private

  def matching_pattern?(keyword)
    !!(message =~ /\s*#{keyword}\s*$/) ||
      splitted_text?(keyword)
  end

  def splitted_text?(keyword)
    !!(message =~ /\s*#{split_text(keyword)}\s*$/)
  end

  def keywords
    backend.map { |keyword, _sentences| keyword }
  end

  def backend
    @backend ||= YAML.load_file(backend_path)
  end

  def split_text(text)
    text.split('').join(' ')
  end

  def backend_path
    File.expand_path(
      File.join(
        File.dirname(__FILE__),
        '../keyword_to_sentence.yml',
      )
    )
  end
end
