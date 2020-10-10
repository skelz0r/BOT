# frozen_string_literal: true

require 'spec_helper'

describe KeywordToSentenceInterceptor, type: :interceptor do
  describe '#match?' do
    subject { instance }

    it { is_expected.to intercept_message('KIKI ') }
    it { is_expected.to intercept_message('T A R T I') }
    it { is_expected.to intercept_message('DES PUTES') }

    it { is_expected.not_to intercept_message('lol') }
    it { is_expected.not_to intercept_message('lol RA lol') }
    it { is_expected.not_to intercept_message('kiki') }
  end

  describe '#reply' do
    subject { instance.reply }

    context 'with KIKI' do
      let(:message) { 'KIKI' }

      it { is_expected.to eq('DO U LUV ME') }
    end

    context 'with DES PUTES' do
      let(:message) { 'DES PUTES' }

      it { is_expected.to eq('DU FROMAGE') }
    end

    context 'with CORN' do
      let(:message) { 'CORN' }

      it { expect(%w[FLAKES FLEX]).to include(subject) }
    end

    context 'with TARTI' do
      let(:message) { 'TARTI' }

      it { is_expected.to eq('FLEX') }
    end

    context 'with T A R T I' do
      let(:message) { 'T A R T I' }

      it { is_expected.to eq('F L E X') }
    end
  end
end
