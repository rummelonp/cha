# coding: utf-8

describe Cha::Client do
  context 'with module configuration' do
    let(:keys) { Cha::Configuration::VALID_OPTIONS_KEYS }

    before do
      Cha.configure do |config|
        keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      Cha.reset
    end

    it 'should inherit module configuration' do
      client = Cha::Client.new
      keys.each do |key|
        expect(client.send(key)).to eql(key)
      end
    end

    context 'with class configuration' do
      let(:configuration) do
        {
          adapter: :typhoeus,
          api_token: 'AT',
          endpoint: 'https://api.twitter.com',
          proxy: 'http://mitukiii:secret@proxy.example.com:8080',
          user_agent: 'Custom User Agent'
        }
      end

      context 'during initialization' do
        it 'should override module configuration' do
          client = Cha::Client.new(configuration)
          keys.each do |key|
            expect(client.send(key)).to eql(configuration[key])
          end
        end
      end

      context 'after initilization' do
        it 'should override module configuration after initialization' do
          client = Cha::Client.new
          configuration.each do |key, value|
            client.send("#{key}=", value)
          end
          keys.each do |key|
            expect(client.send(key)).to eql(configuration[key])
          end
        end
      end
    end
  end

  context 'when have error' do
    let(:client) { Cha.new }

    {
      400 => Cha::BadRequest,
      401 => Cha::NotAuthorized,
      403 => Cha::Forbidden,
      404 => Cha::NotFound,
      499 => Cha::ClientError,
      500 => Cha::InternalServerError,
      501 => Cha::NotImplemented,
      503 => Cha::ServiceUnavailable,
      599 => Cha::ServerError,
    }.each do |status, klass|
      context "when HTTP status is #{status}" do
        before do
          stub_get('me')
            .to_return(status: status, body: '{"errors":["nyan"]}')
        end

        it "should raise #{klass.name} error" do
          expect { client.me }.to raise_error(klass)
        end
      end
    end
  end
end
