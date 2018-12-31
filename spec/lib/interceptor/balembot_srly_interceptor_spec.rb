require 'spec_helper'

describe BalembotSrlyInterceptor, type: :interceptor do
  let(:instance) { BalembotSrlyInterceptor.new(message, user) }
  let(:user) { Hashie::Mash.new(nick: 'lol') }
  let(:message) { 'OKI' }

  describe "#match?" do
    subject { instance }

    context do
      let(:message) { 'SRLY BOT ?' }

      it { expect(subject.match?).to be true }
    end

    context do
      let(:message) { 'srly BOT ?' }

      it { expect(subject.match?).to be false }
    end
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
