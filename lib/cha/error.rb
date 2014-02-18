# coding: utf-8

module Cha
  # Custom error class for rescuing from all ChatWork errors
  Error = Class.new(StandardError)

  # Raised when Tumblr returns the HTTP status code 4xx
  ClientError   = Class.new(Error)
  # Raised when Tumblr returns the HTTP status code 400
  BadRequest    = Class.new(ClientError)
  # Raised when Tumblr returns the HTTP status code 401
  NotAuthorized = Class.new(ClientError)
  # Raised when Tumblr returns the HTTP status code 403
  Forbidden     = Class.new(ClientError)
  # Raised when Tumblr returns the HTTP status code 404
  NotFound      = Class.new(ClientError)

  # Raised when Tumblr returns the HTTP status code 5xx
  ServerError         = Class.new(Error)
  # Raised when Tumblr returns the HTTP status code 500
  InternalServerError = Class.new(ServerError)
  # Raised when Tumblr returns the HTTP status code 501
  NotImplemented      = Class.new(ServerError)
  # Raised when Tumblr returns the HTTP status code 503
  ServiceUnavailable  = Class.new(ServerError)
end
