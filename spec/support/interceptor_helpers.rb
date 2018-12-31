shared_context "interceptor_test_init" do
  let(:instance) { described_class.new(message, user) }

  let(:user) { Hashie::Mash.new(nick: 'lol') }
  let(:message) { 'OKI' }
end
