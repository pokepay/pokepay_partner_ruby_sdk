# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/user_device"

module Pokepay::Request
  class ActivateUserDevice < Request
    def initialize(user_device_id)
      @path = "/user-devices" + "/" + user_device_id + "/activate"
      @method = "POST"
      @body_params = {  }
      @response_class = Pokepay::Response::UserDevice
    end
    attr_reader :response_class
  end
end
