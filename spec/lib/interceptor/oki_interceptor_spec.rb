require 'spec_helper'

describe OkiInterceptor, type: :interceptor do
  describe "#match?" do
    subject { instance }

    context do
      let(:nick) { 'skelz0r' }

      it { is_expected.to intercept_message('OKI?') }
    end

    context do
      let(:message) { 'OKI?' }

      before do
        allow_any_instance_of(OkiInterceptor).to receive(:rand).and_return(random_number)
      end

      context do
        let(:random_number) { 1 }

        it { is_expected.to intercept_message('OKI?') }
      end

      context do
        let(:random_number) { 3 }

        it { is_expected.not_to intercept_message('OKI?') }
      end
    end

    context do
      let(:nick) { 'skelz0r' }

      it { is_expected.not_to intercept_message('lol') }
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
