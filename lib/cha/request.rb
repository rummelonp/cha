# coding: utf-8

module Cha
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
end
