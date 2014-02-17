# coding: utf-8

require 'cha/version'
require 'faraday'

module Cha
  module Configuration
    VALID_OPTIONS_KEYS = [
      :adapter,
      :endpoint,
      :api_token,
      :proxy,
      :user_agent,
    ].freeze

    DEFAULT_ADAPTER    = Faraday.default_adapter
    DEFAULT_ENDPOINT   = 'https://api.chatwork.com/v1'
    DEFAULT_API_TOKEN  = nil
    DEFAULT_PROXY      = nil
    DEFAULT_USER_AGENT = "Cha gem/#{VERSION}".freeze

    attr_accessor *VALID_OPTIONS_KEYS

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
      self
    end

    def options
      VALID_OPTIONS_KEYS.reduce({}) do |options, key|
        options.merge(key => send(key))
      end
    end

    def reset
      self.adapter    = DEFAULT_ADAPTER
      self.endpoint   = DEFAULT_ENDPOINT
      self.api_token  = DEFAULT_API_TOKEN
      self.proxy      = DEFAULT_PROXY
      self.user_agent = DEFAULT_USER_AGENT
      self
    end
  end
end
