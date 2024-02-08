# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/bank_registering_info"

module Pokepay::Request
  class CreateBank < Request
    def initialize(user_device_id, private_money_id, callback_url, kana, rest_args = {})
      @path = "/user-devices" + "/" + user_device_id + "/banks"
      @method = "POST"
      @body_params = { "private_money_id" => private_money_id,
                       "callback_url" => callback_url,
                       "kana" => kana }.merge(rest_args)
      @response_class = Pokepay::Response::BankRegisteringInfo
    end
    attr_reader :response_class
  end
end