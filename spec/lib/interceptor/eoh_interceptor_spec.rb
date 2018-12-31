require 'spec_helper'

describe EohInterceptor, type: :interceptor do
  describe "#match?" do
    subject { instance }

    context do
      let(:message) { 'eoh' }

      it { expect(subject.match?).to be true }
    end

    context do
      let(:message) { 'EOH ' }

      it { expect(subject.match?).to be true }
    end

    context do
      let(:message) { '  eoh' }

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
