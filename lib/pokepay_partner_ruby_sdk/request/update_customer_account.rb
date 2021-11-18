# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/account_with_user"

module Pokepay::Request
  class UpdateCustomerAccount < Request
    def initialize(account_id, rest_args = {})
      @path = "/accounts" + "/" + account_id + "/customers"
      @method = "PATCH"
      @body_params = {  }.merge(rest_args)
      @response_class = Pokepay::Response::AccountWithUser
    end
    attr_reader :response_class
  end
end
