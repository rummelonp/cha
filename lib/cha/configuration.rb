# coding: utf-8

require 'cha/version'
require 'faraday'

module Cha
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {Cha::Client}
    VALID_OPTIONS_KEYS = [
      :adapter,
      :endpoint,
      :api_token,
      :proxy,
      :user_agent,
    ].freeze

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP
    DEFAULT_ADAPTER    = Faraday.default_adapter

    # The endpoint that will be used to connect if none is set
    #
    # @note There is no reason to use any other endpoint at this time
    DEFAULT_ENDPOINT   = 'https://api.chatwork.com/v1'

    # By default, don't set an application api token
    DEFAULT_API_TOKEN  = nil

    # By default, don't use a proxy server
    DEFAULT_PROXY      = nil

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "Cha gem/#{VERSION}  (http://github.com/mitukiii/cha)".freeze

    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
      self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.reduce({}) do |options, key|
        options.merge(key => send(key))
      end
    end

    # Reset all configuration options to defaults
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
