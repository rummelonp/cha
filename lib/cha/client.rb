# coding: utf-8

require 'cha/api'
require 'cha/configuration'
require 'cha/connection'
require 'cha/request'

module Cha
  # Wrapper for the ChatWork REST API
  #
  # @see http://developer.chatwork.com/ja/
  class Client
    include Connection
    include Request
    include API

    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize(options = {})
      options = Cha.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
  end
end
