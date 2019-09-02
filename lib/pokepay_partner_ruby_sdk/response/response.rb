require "net/https"

module Pokepay::Response
  class Response < Net::HTTPResponse
    def initialize(response)
      @body = response.body
      @code = response.code
      @header = response.header
      @http_version = response.http_version
      @message = response.message
    end
    attr_reader :body
    attr_reader :code
    attr_reader :header
    attr_reader :http_version
    attr_reader :message
  end
end
