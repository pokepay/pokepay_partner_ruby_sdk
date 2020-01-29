module Pokepay::Request
  class GetTransaction < Request
    def initialize(transaction_id)
      @path = "/transactions" + transaction_id + 
      @method = "GET"
      @body_params = { "transaction_id" => transaction_id }
      @response_class = Pokepay::Response::Transaction
    end
    attr_reader :response_class
  end
end
