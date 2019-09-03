require "pokepay_partner_ruby_sdk/response/response"

module Pokepay::Response
  class Echo
    def initialize(res)
      @message = res["message"]
    end
    attr_reader :message
  end
end
