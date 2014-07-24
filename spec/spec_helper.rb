# coding: utf-8

unless ENV['CI']
  require 'simplecov'
  SimpleCov.start
end

require 'cha'
require 'rspec'
require 'webmock/rspec'

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.order = :random

  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end

def stub_get(path, endpoint = Cha.endpoint)
  stub_request(:get, endpoint + '/' + path)
end

def stub_post(path, endpoint = Cha.endpoint)
  stub_request(:post, endpoint + '/' + path)
end

def stub_put(path, endpoint = Cha.endpoint)
  stub_request(:put, endpoint + '/' + path)
end

def stub_delete(path, endpoint = Cha.endpoint)
  stub_request(:delete, endpoint + '/' + path)
end
