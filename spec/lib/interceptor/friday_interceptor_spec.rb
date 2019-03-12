require 'spec_helper'

describe FridayInterceptor, type: :interceptor do
  describe "#match?" do
    subject { instance }

    context do
      context "when it's friday" do
        before do
          allow_any_instance_of(Time).to receive(:wday).and_return(5)
        end

        it { is_expected.to intercept_message('vendredi') }
        it { is_expected.to intercept_message('vendredi lol') }

        it { is_expected.not_to intercept_message('srly BOT ?') }
        it { is_expected.not_to intercept_message('dis-donc') }
      end

      context "when it's not friday" do
        before do
          allow_any_instance_of(Time).to receive(:wday).and_return(3)
        end

        it { is_expected.not_to intercept_message('vendredi lol') }
        it { is_expected.not_to intercept_message('srly BOT ?') }
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
