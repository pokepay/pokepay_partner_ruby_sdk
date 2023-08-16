# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/transaction_detail"

module Pokepay::Request
  class CreateTopupTransactionWithCheck < Request
    def initialize(check_id, customer_id, rest_args = {})
      @path = "/transactions" + "/topup" + "/check"
      @method = "POST"
      @body_params = { "check_id" => check_id,
                       "customer_id" => customer_id }.merge(rest_args)
      @response_class = Pokepay::Response::TransactionDetail
    end
    attr_reader :response_class
  end
end
