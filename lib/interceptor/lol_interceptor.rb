# frozen_string_literal: true

class LolInterceptor < BaseInterceptor
  def match?
    !!(message =~ /\s*lo+l\s*$/i) ||
      !!(message =~ /\s*mdr\s*$/i) ||
      !!(message =~ /\s*ahah\s*$/i) ||
      !!(message =~ /\s*haha\s*$/i)
  end

  def reply
    [
      "On arrête de s'amuser au fond svp, merci",
      "C'est non.",
      "C'est pas très clame ici",
    ].sample
  end
end
