# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/cpm_token"

module Pokepay::Request
  class GetCpmToken < Request
    def initialize(cpm_token)
      @path = "/cpm" + "/" + cpm_token
      @method = "GET"
      @body_params = {  }
      @response_class = Pokepay::Response::CpmToken
    end
    attr_reader :response_class
  end
end
