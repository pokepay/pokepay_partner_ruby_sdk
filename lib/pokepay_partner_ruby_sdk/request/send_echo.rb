require "pokepay_partner_ruby_sdk/response/echo"

module Pokepay::Request
  class SendEcho < Request
    def initialize(message)
      @path = "/echo"
      @method = "POST"
      @body_params = {"message" => message}
      @response_class = Pokepay::Response::Echo
    end
  end
end
