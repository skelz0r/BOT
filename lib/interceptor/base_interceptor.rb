# frozen_string_literal: true

class BaseInterceptor
  attr_reader :message,
              :user

  def initialize(message, user)
    @message = message
    @user = user
  end

  def match?
    raise 'Should be overwrite in inherited classes'
  end

  def reply
    raise 'Should be overwrite in inherited classes'
  end
end
