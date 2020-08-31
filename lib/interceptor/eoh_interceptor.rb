VICTIMS = [
  'Amora',
  ['Tata']*5,
  'Skelz0r',
].flatten

ANSWERS = [
  'on se clap au fond svp',
  'on se corn au fond svp',
  'on se clame au fond svp',
  'on se klam au fond svp',
  'on se clape au fond svp',
  'on se skelz0r au fond svp',
  'on se thurolf au fond svp',
  'on se tata au fond svp',
  'ça coinche au fond svp',
  'c\'est coinché au fond svp',
  'on se stuff au fond svp',
  'on se ghost au fond svp',
  'on se profile au fond svp',
  'on se pakito au fond svp',
  'on se Guinness dans le hall svp',
  'on picole au fond svp',
  'ça vieillit au fond svp',
  'on se canne au fond svp',
  'ça compact au fond svp',
  'ça raclette au fond svp',
  'ça tartiflette au fond svp',
  'SYRAGE au fond svp',
  'on s\'égare au fond svp',
  'eoh, on rentre du boulot',
  'on se conf au fond svp',
  'ça picole au Little',
  'on se ramen au fond svp',
  'ça Gicle au fond svp',
]


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
    if rand_tg
      "TG #{random_victim}"
    else
      ANSWERS.sample.capitalize
    end
  end

  def random_victim
    VICTIMS.sample
  end

  def rand_tg
    rand(30) == 1
  end

  def uppercase_message?
    !(message =~ /[[:lower:]]/) # negative match, fail the predicate on the first lowercase character
  end
end
