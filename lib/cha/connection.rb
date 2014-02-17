# coding: utf-8

require 'cha/middleware'
require 'faraday'
require 'faraday_middleware'

module Cha
  module Connection
    def connection(options = {})
      options = options.merge(
        headers: {
          accept: 'application/json',
          user_agent: user_agent,
        },
        proxy: proxy,
        url: endpoint,
      )

      Faraday::Connection.new(options) do |builder|
        builder.request :chat_work, api_token
        builder.request :multipart
        builder.request :url_encoded
        builder.response :raise_error
        builder.response :mashify
        builder.response :json
        builder.adapter adapter
      end
    end
  end
end
