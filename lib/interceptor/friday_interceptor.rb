class FridayInterceptor < BaseInterceptor
  def match?
    friday? &&
      !!(message =~ /di(\s|$)/i)
  end

  def reply
    'DI :D'
  end

  private

  def friday?
    Time.now.wday == 5
  end
end
