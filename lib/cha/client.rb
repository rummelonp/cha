# coding: utf-8

require 'cha/api'
require 'cha/configuration'
require 'cha/connection'
require 'cha/request'

module Cha
  class Client
    include Configuration
    include Connection
    include Request
    include Me
    include My
    include Contacts
    include Rooms

    def initialize(options = {})
      options = Cha.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
  end
end
