# coding: utf-8

require 'multi_json'
require 'faraday'
require 'faraday_middleware'

module Cha
  module Middleware
    class ChatWorkAuthentication < Faraday::Middleware
      KEY = 'X-ChatWorkToken'

      def initialize(app, token)
        @token = token
        super(app)
      end

      def call(env)
        if @token
          env[:request_headers][KEY] ||= @token
        end
        @app.call(env)
      end
    end

    class ParseJson < Faraday::Response::Middleware
      def parse(body)
        MultiJson.load(body) unless body.nil?
      end
    end

    Faraday.register_middleware :request, chat_work: ->{ ChatWorkAuthentication }
    Faraday.register_middleware :response, json: ->{ ParseJson }
  end
end
