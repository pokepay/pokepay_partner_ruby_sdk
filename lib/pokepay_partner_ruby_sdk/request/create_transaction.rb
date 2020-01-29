module Pokepay::Request
  class CreateTransaction < Request
    def initialize(shop_id, customer_id, private_money_id, rest_args = {})
      @path = "/transactions"
      @method = "POST"
      @body_params = { "shop_id" => shop_id,
                       "customer_id" => customer_id,
                       "private_money_id" => private_money_id }.merge(rest_args)
      @response_class = Pokepay::Response::Transaction
    end
    attr_reader :response_class
  end
end
