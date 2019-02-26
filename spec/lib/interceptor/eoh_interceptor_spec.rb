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

    context "non-uppercase message" do
      let(:message) { 'Random casing EOh' }

      it "does not upcase the answer" do
        expect_any_instance_of(String).not_to receive(:upcase)
        subject
      end
    end

    context "uppercase message" do
      let(:message) { 'UPPERCASE EOH' }

      it "should uppercase the reply if the message itself was in uppercase" do
        expect(subject).to eq(subject.upcase)
      end
    end

    context "when it's a rand_tg" do
      before do
        allow_any_instance_of(EohInterceptor).to receive(:rand_tg).and_return(true)
      end

      it do
        expect(subject).to match(/TG/)
      end

      it do
        expect(subject).to be_a(String)
      end
    end
  end
end
