# coding: utf-8

require 'spec_helper'

describe Cha do
  after do
    Cha.reset
  end

  context 'when delegating to a client' do
    before do
      stub_get('me')
        .to_return(body: '{"nyan":"にゃーん"}')
    end

    it 'should request the correct resource' do
      Cha.me
    end

    it 'should return the same results as a client' do
      expect(Cha.me).to eql(Cha::Client.new.me)
    end
  end

  describe '.new' do
    it 'should return a Cha::Client' do
      expect(Cha.new).to be_is_a(Cha::Client)
    end
  end

  describe '.respond_to?' do
    it 'should take an optional argument' do
      expect(Cha.respond_to?(:new, true)).to be_true
    end
  end

  describe '.adapter' do
    it 'should return the default adapter' do
      expect(Cha.adapter).to eql(Cha::Configuration::DEFAULT_ADAPTER)
    end
  end

  describe '.adapter=' do
    it 'should set the adapter' do
      Cha.adapter = :typhoeus
      expect(Cha.adapter).to eql(:typhoeus)
    end
  end

  describe '.endpoint' do
    it 'should return the default endpoint' do
      expect(Cha.endpoint).to eql(Cha::Configuration::DEFAULT_ENDPOINT)
    end
  end

  describe '.endpoint=' do
    it 'should set the endpoint' do
      Cha.endpoint = 'https://api.twitter.com/'
      expect(Cha.endpoint).to eql('https://api.twitter.com/')
    end
  end

  describe '.user_agent' do
    it 'should return the default user agent' do
      expect(Cha.user_agent).to eql(Cha::Configuration::DEFAULT_USER_AGENT)
    end
  end

  describe '.user_agent=' do
    it 'should set the user_agent' do
      Cha.endpoint = 'Custom User Agent'
      expect(Cha.endpoint).to eql('Custom User Agent')
    end
  end

  describe '.configure' do
    Cha::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set the #{key}" do
        Cha.configure do |config|
          config.send("#{key}=", key)
          expect(Cha.send(key)).to eql(key)
        end
      end
    end
  end
end
