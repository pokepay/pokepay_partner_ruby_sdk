module Pokepay::Request
  class ListTransactions < Request
    def initialize(rest_args = {})
      @path = "/transactions"
      @method = "GET"
      @body_params = {  }.merge(rest_args)
      @response_class = Pokepay::Response::PaginatedTransaction
    end
    attr_reader :response_class
  end
end
