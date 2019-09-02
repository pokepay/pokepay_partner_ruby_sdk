require "pokepay_partner_ruby_sdk/response/transactions"

module Pokepay::Request
  class ListTransactions < Request
    def initialize(filter_args)
      @path = "/transactions"
      @method = "GET"
      @body_params = filter_args
      @response_class = Pokepay::Response::Transactions
    end
  end
end
