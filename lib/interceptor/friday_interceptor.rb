# frozen_string_literal: true

class FridayInterceptor < BaseInterceptor
  def match?
    friday? &&
      !!(message =~ /di(\s|$)/i)
  end

  def reply
    [
      'DI :D',
      'DI \o',
      'DI',
      'di',
      'DiIiIIiIiiIIiiiI',
      'DI',
    ].sample
  end

  private

  def friday?
    Time.now.wday == 5
  end
end
