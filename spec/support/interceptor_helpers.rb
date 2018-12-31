shared_context "interceptor_test_init" do
  let(:instance) { described_class.new(message, user) }

  let(:user) { Hashie::Mash.new(nick: nick) }
  let(:message) { 'OKI' }
  let(:nick) { 'Lol' }
end
