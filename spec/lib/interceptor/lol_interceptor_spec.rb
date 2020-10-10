# frozen_string_literal: true

require 'spec_helper'

describe LolInterceptor, type: :interceptor do
  describe '#match?' do
    subject { instance }

    it { is_expected.to intercept_message('lol') }
    it { is_expected.to intercept_message(' loool') }
    it { is_expected.to intercept_message('mdr') }
    it { is_expected.to intercept_message('ahah') }
    it { is_expected.to intercept_message('haha') }

    it { is_expected.not_to intercept_message(' loool ok') }
    it { is_expected.not_to intercept_message('aha') }
    it { is_expected.not_to intercept_message('ha ok') }
    it { is_expected.not_to intercept_message('ah ok') }
  end

  describe '#reply' do
    subject { instance.reply }

    it do
      expect {
        subject
      }.not_to raise_error
    end
  end
end
