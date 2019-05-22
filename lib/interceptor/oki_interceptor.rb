class OkiInterceptor < BaseInterceptor
  def match?
    !!(message =~ /(^|\s+)OKI\s*\?\s*$/) &&
      (whitelist_nicks || rand(random_for_another_user) == 1)
  end

  def reply
    'OKI'
  end

  private

  def random_for_another_user
    5
  end

  def whitelist_nicks
    [
      'skelz0r',
      'feriel',
      'kiddo',
    ].any? do |nick|
      user.nick.downcase == nick
    end
  end
end
