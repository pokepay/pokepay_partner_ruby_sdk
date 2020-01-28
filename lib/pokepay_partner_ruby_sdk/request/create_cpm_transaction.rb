module Pokepay::Request
  class CreateCpmTransaction < Request
    def initialize(cpm_token, amount, shop_id, rest_args = {})
      @path = "/transactions""/cpm"
      @method = "POST"
      @body_params = { "cpm_token" => cpm_token,
                       "amount" => amount,
                       "shop_id" => shop_id }.merge(rest_args)
      @response_class = Pokepay::Response::Transaction
    end
    attr_reader :response_class
  end
end
