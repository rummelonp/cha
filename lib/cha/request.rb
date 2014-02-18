# coding: utf-8

module Cha
  module Request
    # Perform an HTTP GET request
    def get(path, params = {})
      request(:get, path, params)
    end

    # Perform an HTTP POST request
    def post(path, params = {})
      request(:post, path, params)
    end

    # Perform an HTTP PUT request
    def put(path, params = {})
      request(:put, path, params)
    end

    # Perform an HTTP DELETE request
    def delete(path, params = {})
      request(:delete, path, params)
    end

    # Perform an HTTP request
    def request(http_method, path, params)
      response = connection.send(http_method, path, params)
      response.body
    end
  end
end
