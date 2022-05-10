# frozen_string_literal: true

require 'date'

VICTIMS = [
  'Amora',
  ['Tata'] * 5,
  'Skelz0r',
].flatten.freeze

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
    elsif hled_user
      "#{hled_user}, #{answers.sample}"
    else
      answers.sample.capitalize
    end
  end

  def hled_user
    if /^(?<user>[A-Za-z_]+)[,:]/ =~ message
      user
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
      'On se tata au fond svp',
      'Ça coinche au fond svp',
      'C\'est coinché au fond svp',
      'On se stuff au fond svp',
      'On se ghost au fond svp',
      'On se profile au fond svp',
      'On se pakito au fond svp',
      'On se Guinness dans le hall svp',
      'On picole au fond svp',
      'Ça vieillit au fond svp',
      'On se canne au fond svp',
      'Ça compact au fond svp',
      'Ça raclette au fond svp',
      'Ça tartiflette au fond svp',
      'SYRAGE au fond svp',
      'On s\'égare au fond svp',
      'eoh, on rentre du boulot',
      'On se conf au fond svp',
      'On se ramen au fond svp',
      'Ça Gicle au fond svp',
      'FAIS TON CV MOISE',
      *('Ça picole au Little le mardi' if Date.today.tuesday?),
    ]
  end

  def random_victim
    VICTIMS.sample
  end

  def rand_tg
    rand(30) == 1
  end

  def uppercase_message?
    message !~ /[[:lower:]]/
  end
end
