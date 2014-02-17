# coding: utf-8
require 'cha/version'
require 'faraday'
require 'faraday_middleware'
require 'multi_json'

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
        builder.response :mashify
        builder.response :json
        builder.adapter adapter
      end
    end
  end

  module Request
    def get(path, params = {})
      request(:get, path, params)
    end

    def post(path, params = {})
      request(:post, path, params)
    end

    def put(path, params = {})
      request(:put, path, params)
    end

    def delete(path, params = {})
      request(:delete, path, params)
    end

    def request(http_method, path, params)
      response = connection.send(http_method, path, params)
      response.body
    end
  end

  module Me
    def me
      get('me')
    end
  end

  module My
    def my_status
      get('my/status')
    end

    def my_tasks
      get('my/tasks')
    end
  end

  module Contacts
    def contacts
      get('contacts')
    end
  end

  module Rooms
    def rooms
      get('rooms')
    end

    def room(room_id)
      get("rooms/#{room_id}")
    end

    def room_members(room_id)
      get("rooms/#{room_id}/members")
    end

    def room_messages(room_id)
      get("rooms/#{room_id}/messages")
    end

    def room_tasks(room_id)
      get("rooms/#{room_id}/tasks")
    end

    def room_task(room_id, task_id)
      get("rooms/#{room_id}/tasks/#{task_id}")
    end

    def room_files(room_id)
      get("rooms/#{room_id}/files")
    end

    def room_file(room_id, file_id)
      get("rooms/#{room_id}/files/#{file_id}")
    end
  end

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

  extend Configuration

  def self.client(options = {})
    Client.new(options)
  end

  def self.respond_to_missing?(method_name, include_private = false)
    client.respond_to?(method_name, include_private)
  end

  def self.method_missing(method_name, *args, &block)
    return super unless client.respond_to?(method_name)
    client.send(method_name, *args, &block)
  end
end
