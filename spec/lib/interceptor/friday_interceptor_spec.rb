require 'spec_helper'

describe FridayInterceptor, type: :interceptor do
  describe "#match?" do
    subject { instance }

    context do
      let(:message) { 'vendredi' }

      context "when it's friday" do
        before do
          allow_any_instance_of(Time).to receive(:wday).and_return(5)
        end

        it { expect(subject.match?).to be true }
      end
    end

    context do
      let(:message) { 'vendredi lol' }

      context "when it's friday" do
        before do
          allow_any_instance_of(Time).to receive(:wday).and_return(5)
        end

        it { expect(subject.match?).to be true }
      end

      context "when it's not friday" do
        before do
          allow_any_instance_of(Time).to receive(:wday).and_return(3)
        end

        it { expect(subject.match?).to be false }
      end
    end

    context do
      let(:message) { 'srly BOT ?' }

      it { expect(subject.match?).to be false }

      context "when it's friday" do
        before do
          allow_any_instance_of(Time).to receive(:wday).and_return(5)
        end

        it { expect(subject.match?).to be false }
      end
    end

    context do
      let(:message) { 'dis-donc' }

      it { expect(subject.match?).to be false }

      context "when it's friday" do
        before do
          allow_any_instance_of(Time).to receive(:wday).and_return(5)
        end

        it { expect(subject.match?).to be false }
      end
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
