module Pokepay::Request
  class CreateCheck < Request
    def initialize(account_id, rest_args = {})
      @path = "/checks"
      @method = "POST"
      @body_params = { "account_id" => account_id }.merge(rest_args)
      @response_class = Pokepay::Response::Check
    end
    attr_reader :response_class
  end
end
