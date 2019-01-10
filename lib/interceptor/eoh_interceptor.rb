class EohInterceptor < BaseInterceptor
  def match?
    !!(message =~ /\s*eoh\s*$/i)
  end

  def reply
    if uppercase_message?
      answer.upcase
    else
      answer
    end
  end

  private

  def answer
    if rand(amora_rand) == 1
      'TG Amora'
    else
      answers.sample
    end
  end

  def answers
    [
      'On se clap au fond svp',
      'On se corn au fond svp',
      'On se clame au fond svp',
      'On se klam au fond svp',
      'On se clape au fond svp',
      'On se skelz0r au fond svp',
      'On se thurolf au fond svp',
      'Ça coinche au fond svp',
      'C\'est coinché au fond svp',
      'On se stuff au fond svp',
      'On se ghost au fond svp',
      'On se profile au fond svp',
      'On se pakito au fond svp',
      'On se guinness dans le hall svp',
      'On picole au fond svp',
      'On se canne au fond svp',
      'Ça compact au fond svp',
      'On s\'égare au fond svp',
    ]
  end

  def amora_rand
    50
  end

  def uppercase_message?
    !(message =~ /[[:lower:]]/) # negative match, fail the predicate on the first lowercase character
  end
end
