# frozen_string_literal: true

require 'spec_helper'

describe SyllabeExtractor do
  let(:service) { SyllabeExtractor.new(sentence) }

  describe '#perform' do
    subject { service.perform }

    context 'with trivial sentence' do
      let(:sentence) { "J'aime les tomates" }

      it { is_expected.to eq('MATES') }
    end
  end
end
