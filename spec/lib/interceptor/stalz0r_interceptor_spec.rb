# frozen_string_literal: true

require 'spec_helper'

describe Stalz0rInterceptor, type: :interceptor do
  describe '#match?' do
    subject { instance }

    it { is_expected.to intercept_message('stalz0r') }
    it { is_expected.to intercept_message('STALZ0R') }
    it { is_expected.to intercept_message('   stalz0r') }
    it { is_expected.not_to intercept_message('stalz0r oki') }
  end

  describe '#reply' do
    subject { instance.reply }

    it { is_expected.to eq("CHERCHE PAS T'AS TORT") }
  end
end
