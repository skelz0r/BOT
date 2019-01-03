require 'spec_helper'

describe KeywordToSentenceInterceptor, type: :interceptor do
  describe "#match?" do
    subject { instance }

    context do
      let(:message) { 'KIKI ' }

      it { expect(subject.match?).to be true }
    end

    context do
      let(:message) { 'T A R T I' }

      it { expect(subject.match?).to be true }
    end

    context do
      let(:message) { 'DES PUTES' }

      it { expect(subject.match?).to be true }
    end

    context do
      let(:message) { 'lol' }

      it { expect(subject.match?).to be false }
    end

    context do
      let(:message) { 'lol RA lol' }

      it { expect(subject.match?).to be false }
    end

    context do
      let(:message) { 'kiki' }

      it { expect(subject.match?).to be false }
    end
  end

  describe "#reply" do
    subject { instance.reply }

    context "with KIKI" do
      let(:message) { 'KIKI' }

      it { is_expected.to eq('DO U LUV ME') }
    end

    context "with DES PUTES" do
      let(:message) { 'DES PUTES' }

      it { is_expected.to eq('DU FROMAGE') }
    end

    context "with CORN" do
      let(:message) { 'CORN' }

      it { expect(['FLAKES', 'FLEX']).to include(subject) }
    end

    context "with TARTI" do
      let(:message) { 'TARTI' }

      it { is_expected.to eq('FLEX') }
    end

    context "with T A R T I" do
      let(:message) { 'T A R T I' }

      it { is_expected.to eq('F L E X') }
    end
  end
end
