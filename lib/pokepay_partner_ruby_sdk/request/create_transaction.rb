require "pokepay_partner_ruby_sdk/response/transaction"

module Pokepay::Request
  class CreateTransaction < Request
    def initialize(shop_id, customer_id, private_money_id, money_amount, point_amount, description)
      @path = "/transactions"
      @method = "POST"
      @body_params = { "shop_id" => shop_id,
                       "customer_id" => customer_id,
                       "private_money_id" => private_money_id,
                       "money_amount" => money_amount,
                       "point_amount" => point_amount,
                       "description" => description }
      @response_class = Pokepay::Response::Transaction
    end
  end
end
