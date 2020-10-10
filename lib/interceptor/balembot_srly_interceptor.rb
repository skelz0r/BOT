# frozen_string_literal: true

class BalembotSrlyInterceptor < BaseInterceptor
  def match?
    message == 'SRLY BOT ?'
  end

  def reply
    [
      'Oui',
      'Non',
      'Je ne sais pas',
      'TG',
      'SLRY* stp',
      'On se clame au fond svp merci',
    ].sample
  end
end
