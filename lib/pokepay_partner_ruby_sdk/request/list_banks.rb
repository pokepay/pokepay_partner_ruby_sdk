# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/banks"

module Pokepay::Request
  class ListBanks < Request
    def initialize(user_device_id, rest_args = {})
      @path = "/user-devices" + "/" + user_device_id + "/banks"
      @method = "GET"
      @body_params = {  }.merge(rest_args)
      @response_class = Pokepay::Response::Banks
    end
    attr_reader :response_class
  end
end
