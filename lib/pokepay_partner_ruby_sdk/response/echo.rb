require "pokepay_partner_ruby_sdk/response/response"

module Pokepay::Response
  class Echo < Response
    def initialize(response)
      super(response)
      @message = response.body["message"]
    end
  end
end
