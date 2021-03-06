# frozen_string_literal: true

require 'spec_helper'
require 'timecop'

describe EohInterceptor, type: :interceptor do
  describe '#match?' do
    subject { instance }

    it { is_expected.to intercept_message('eoh') }
    it { is_expected.to intercept_message('EOH ') }
    it { is_expected.to intercept_message('   eoh') }
    it { is_expected.not_to intercept_message('srly BOT ?') }
  end

  describe '#reply' do
    let(:message) { 'eoh' }

    subject { instance.reply }

    it do
      expect {
        subject
      }.not_to raise_error
    end

    context "when it's not a random TG" do
      before do
        allow_any_instance_of(EohInterceptor).to receive(:rand_tg).and_return(false)
      end

      context 'non-uppercase message' do
        let(:message) { 'Random casing EOh' }

        it 'does not upcase the answer' do
          expect_any_instance_of(String).not_to receive(:upcase)
          subject
        end
      end

      context 'uppercase message' do
        let(:message) { 'UPPERCASE EOH' }

        it 'should uppercase the reply if the message itself was in uppercase' do
          expect(subject).to eq(subject.upcase)
        end
      end

      context "when it's an hl eoh with comma" do
        let(:message) { 'Tata, eoh' }

        it 'should reply why an hl too' do
          expect(subject).to match(/^Tata, /)
        end
      end

      context "when it's an hl eoh with colon" do
        let(:message) { 'Tata: eoh' }

        it 'should reply why an hl too' do
          expect(subject).to match(/^Tata, /)
        end
      end

      describe 'drinking at Little' do
        tuesday = Date.parse('tuesday')
        line = 'Ça picole au Little le mardi'

        subject { instance.send(:answers) }

        Date::DAYNAMES.each do |d|
          day = Date.parse(d)

          context "when it's #{d}" do
            if day == tuesday
              it 'is OK' do
                Timecop.travel(day)
                expect(subject).to include(line)
              end
            else
              it 'is not OK' do
                Timecop.travel(day)
                expect(subject).not_to include(line)
              end
            end
          end
        end
      end
    end

    context "when it's a random TG" do
      before do
        allow_any_instance_of(EohInterceptor).to receive(:rand_tg).and_return(true)
      end

      it 'should say TG to a single person' do
        expect(subject).to match(/TG \S+/)
      end

      it do
        expect(subject).to be_a(String)
      end
    end
  end
end
