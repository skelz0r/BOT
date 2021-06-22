# frozen_string_literal: true

require 'spec_helper'

describe SentenceToSoundSample do
  let(:service) { SentenceToSoundSample.new(sentence) }
  let(:sentence) { 'LOL' }

  before do
    allow_any_instance_of(SentenceToSoundSample).to receive(:sound_options).and_return({
      pitch: 100,
      speed: 1.0,
    })

    ENV['SOUNDS_PATH'] = "#{File.expand_path(File.join(File.dirname(__FILE__), '../../sounds/'))}/"
  end

  describe '#perform' do
    subject { service.perform }

    it 'creates a file' do
      expect {
        subject
      }.to change { Dir.new(ENV['SOUNDS_PATH']).entries.count }.by(1)
    end
  end

  describe '#url' do
    subject do
      service.perform
      service.url
    end

    it 'renders a valid url' do
      expect(subject).to start_with('HTTP://')
    end
  end
end
