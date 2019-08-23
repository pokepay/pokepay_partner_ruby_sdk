module Pokepay::Request
  class SendEcho < Request
    def initialize(message)
      @path = "/echo"
      @method = "POST"
      @body_params = {"message" => message}
    end
  end
end
