# coding: utf-8

require 'cha/client'
require 'cha/configuration'

module Cha
  extend Configuration

  # Alias for Cha::Client.new
  #
  # @return [Cha::Client]
  def self.new(options = {})
    Client.new(options)
  end

  # Delegate to {Cha::Client}
  def self.method_missing(method_name, *args, &block)
    return super unless new.respond_to?(method_name)
    new.send(method_name, *args, &block)
  end

  # Delegate to {Cha::Client}
  def self.respond_to?(method_name, include_private = false)
    new.respond_to?(method_name, include_private) || super
  end
end
