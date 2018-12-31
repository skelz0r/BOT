class EohInterceptor < BaseInterceptor
  def match?
    !!(message =~ /\s*eoh\s*$/i)
  end

  def reply
    if rand(amora_rand) == 1
      'TG Amora'
    else
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
        'On s\'égare au fond svp',
      ].sample
    end
  end

  private

  def amora_rand
    50
  end
end
