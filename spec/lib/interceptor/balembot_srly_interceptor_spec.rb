require 'spec_helper'

describe BalembotSrlyInterceptor, type: :interceptor do
  describe "#match?" do
    subject { instance }

    it { is_expected.to intercept_message('SRLY BOT ?') }
    it { is_expected.not_to intercept_message('srly BOT ?') }
  end

  describe "#reply" do
    subject { instance.reply }

    it do
      expect {
        subject
      }.not_to raise_error
    end
  end
end
