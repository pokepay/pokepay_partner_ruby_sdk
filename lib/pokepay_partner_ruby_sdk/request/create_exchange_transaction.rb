# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/transaction_detail"

module Pokepay::Request
  class CreateExchangeTransaction < Request
    def initialize(user_id, sender_private_money_id, receiver_private_money_id, amount, rest_args = {})
      @path = "/transactions" + "/exchange"
      @method = "POST"
      @body_params = { "user_id" => user_id,
                       "sender_private_money_id" => sender_private_money_id,
                       "receiver_private_money_id" => receiver_private_money_id,
                       "amount" => amount }.merge(rest_args)
      @response_class = Pokepay::Response::TransactionDetail
    end
    attr_reader :response_class
  end
end
