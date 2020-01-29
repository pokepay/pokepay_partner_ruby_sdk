module Pokepay::Request
  class GetUser < Request
    def initialize()
      @path = "/user"
      @method = "GET"
      @body_params = {  }
      @response_class = Pokepay::Response::AdminUserWithShopsAndPrivateMoneys
    end
    attr_reader :response_class
  end
end
