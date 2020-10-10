# frozen_string_literal: true

class Stalz0rInterceptor < BaseInterceptor
  def match?
    !!(message =~ /\s*stalz0r\s*$/i)
  end

  def reply
    "CHERCHE PAS T'AS TORT"
  end
end
