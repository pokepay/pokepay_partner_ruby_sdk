module Pokepay::Request
  class CreateShop < Request
    def initialize(shop_name, rest_args = {})
      @path = "/shops"
      @method = "POST"
      @body_params = { "shop_name" => shop_name }.merge(rest_args)
      @response_class = Pokepay::Response::User
    end
    attr_reader :response_class
  end
end
