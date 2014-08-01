require 'cinch'
require 'text/hyphen'

class Austisme
  def initialize(sentence)
    @hh = Text::Hyphen.new(language: 'fr')
    @points = @hh.hyphenate(sentence)
    @sentence = sentence
  end

  def say
    index = @points[-1]
    sentence = @points.empty? ? @sentence : @sentence[index..-1]
    upcase(sanitize_punctuation(sentence))
  end

  protected

  def sanitize_punctuation(sentence)
    sentence.gsub(/ +[^\w\s]*$/, "").gsub(/ *<3/, "").gsub("*", "")
  end

  def upcase(string)
    string.upcase.gsub(/[æøåäâãàáëêèéïîìíöôõòóüûùúý]/){|s| (s.ord-32).chr(Encoding::UTF_8)}
  end
end

bot = Cinch::Bot.new do
  configure do |c|
    c.nick = "BOT"
    c.server = "irc.iiens.net"
    c.channels = ["#balemboy"]
  end

  on :message, /.*/ do |m|
    begin
      m.reply Austisme.new(m.message).say if rand(50) == 1
    rescue
      m.reply "DOH"
    end
  end
end

bot.start
