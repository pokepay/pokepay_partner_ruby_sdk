# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/bill"

module Pokepay::Request
  class UpdateBill < Request
    def initialize(bill_id, rest_args = {})
      @path = "/bills" + "/" + bill_id
      @method = "PATCH"
      @body_params = {  }.merge(rest_args)
      @response_class = Pokepay::Response::Bill
    end
    attr_reader :response_class
  end
end
