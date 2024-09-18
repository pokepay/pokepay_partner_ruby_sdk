module Pokepay::Request
  class Request
    def initialize()
      @path = "/"
      @method = "GET"
      @body_params = nil
      @response_class = nil
    end
    attr_reader :path
    attr_reader :method
    attr_reader :body_params
    attr_reader :response_class

    def retriable?()
      ['GET', 'PATCH'].include?(@method) || @body_params && @body_params.key?('request_id')
    end
  end
end
