# frozen_string_literal: true

module InterceptorMatcher
  class InterceptMessage
    attr_reader :text, :user, :interceptor

    def initialize(text, user=nil)
      @text = text
      @user = user || Hahie::Mash.new(nick: 'skelz0r')
    end

    def matches?(interceptor)
      @interceptor = interceptor.class
      @interceptor.new(text, user).match?
    end

    def description
      "intercept '#{text}' message"
    end

    def failure_message
      "Expect #{interceptor} to intercept '#{text}' message"
    end

    def failure_message_when_negated
      "Expect #{interceptor} to not intercept '#{text}' message"
    end
  end

  def intercept_message(text)
    if defined?(user)
      InterceptMessage.new(text, user)
    else
      InterceptMessage.new(text)
    end
  end
end
