# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/transaction_detail"

module Pokepay::Request
  class CreatePaymentTransaction < Request
    def initialize(shop_id, customer_id, private_money_id, amount, rest_args = {})
      @path = "/transactions" + "/payment"
      @method = "POST"
      @body_params = { "shop_id" => shop_id,
                       "customer_id" => customer_id,
                       "private_money_id" => private_money_id,
                       "amount" => amount }.merge(rest_args)
      @response_class = Pokepay::Response::TransactionDetail
    end
    attr_reader :response_class
  end
end
