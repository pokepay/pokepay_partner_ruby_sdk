module Pokepay::Request
  class CreateEcho < Request
    def initialize(message)
      @path = "/echo"
      @method = "POST"
      @body_params = { "message" => message }
      @response_class = Pokepay::Response::Echo
    end
    attr_reader :response_class
  end
end
