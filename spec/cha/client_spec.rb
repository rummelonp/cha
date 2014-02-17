# coding: utf-8

require 'spec_helper'

describe Cha::Client do
  context :api do
    let(:api_token) { 'api_token' }
    let(:client) { Cha.new(api_token: api_token) }

    describe '#me' do
      it 'should request the correct resource' do
        stub_get('me')
        client.me
      end
    end

    describe '#my_status' do
      it 'should request the correct resource' do
        stub_get('my/status')
        client.my_status
      end
    end

    describe '#my_tasks' do
      it 'should request the correct resource' do
        stub_get('my/tasks')
        client.my_tasks
      end
    end

    describe '#contacts' do
      it 'should request the correct resource' do
        stub_get('contacts')
        client.contacts
      end
    end

    describe '#rooms' do
      it 'should request the correct resource' do
        stub_get('rooms')
        client.rooms
      end
    end

    describe '#create_room' do
      pending
    end

    describe '#room' do
      it 'should request the correct resource' do
        stub_get('rooms/1')
        client.room(1)
      end
    end

    describe '#update_room' do
      pending
    end

    describe '#destroy_room' do
      pending
    end

    describe '#room_members' do
      it 'should request the correct resource' do
        stub_get('rooms/1/members')
        client.room_members(1)
      end
    end

    describe '#update_room_members' do
      pending
    end

    describe '#room_messages' do
      it 'should request the correct resource' do
        stub_get('rooms/1/messages')
        client.room_messages(1)
      end
    end

    describe '#create_room_message' do
      pending
    end

    describe '#room_message' do
      pending
    end

    describe '#room_tasks' do
      it 'should request the correct resource' do
        stub_get('rooms/1/tasks')
        client.room_tasks(1)
      end
    end

    describe '#create_room_task' do
      pending
    end

    describe '#room_task' do
      it 'should request the correct resource' do
        stub_get('rooms/1/tasks/1')
        client.room_task(1, 1)
      end
    end

    describe '#room_files' do
      it 'should request the correct resource' do
        stub_get('rooms/1/files')
        client.room_files(1)
      end
    end

    describe '#room_file' do
      it 'should request the correct resource' do
        stub_get('rooms/1/files/1')
        client.room_file(1, 1)
      end
    end
  end

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
