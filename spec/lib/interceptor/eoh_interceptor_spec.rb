require 'spec_helper'

describe EohInterceptor, type: :interceptor do
  describe "#match?" do
    subject { instance }

    it { is_expected.to intercept_message('eoh') }
    it { is_expected.to intercept_message('EOH ') }
    it { is_expected.to intercept_message('   eoh') }
    it { is_expected.not_to intercept_message('srly BOT ?') }
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

      it "should say TG to a single person" do
        expect(subject).to match(/TG \S+/)
      end

      it do
        expect(subject).to be_a(String)
      end
    end

    context "when it's an hl eoh with comma" do
      let(:message) { "Tata, eoh" }

      it "should reply why an hl too" do
        expect(subject).to match(/^Tata, /)
      end
    end

    context "when it's an hl eoh with colon" do
      let(:message) { "Tata: eoh" }

      it "should reply why an hl too" do
        expect(subject).to match(/^Tata, /)
      end
    end
  end
end
