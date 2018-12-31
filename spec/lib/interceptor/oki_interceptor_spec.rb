require 'spec_helper'

describe OkiInterceptor, type: :interceptor do
  describe "#match?" do
    subject { instance }

    context do
      let(:message) { 'OKI?' }
      let(:nick) { 'skelz0r' }

      it { expect(subject.match?).to be true }
    end

    context do
      let(:message) { 'OKI?' }

      before do
        allow_any_instance_of(OkiInterceptor).to receive(:rand).and_return(random_number)
      end

      context do
        let(:random_number) { 1 }

        it { expect(subject.match?).to be true }
      end

      context do
        let(:random_number) { 3 }

        it { expect(subject.match?).to be false }
      end
    end

    context do
      let(:message) { 'lol' }
      let(:nick) { 'skelz0r' }

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
