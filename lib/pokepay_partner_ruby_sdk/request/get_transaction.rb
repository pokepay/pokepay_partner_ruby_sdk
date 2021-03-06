# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/transaction"

module Pokepay::Request
  class GetTransaction < Request
    def initialize(transaction_id)
      @path = "/transactions" + "/" + transaction_id
      @method = "GET"
      @body_params = {  }
      @response_class = Pokepay::Response::Transaction
    end
    attr_reader :response_class
  end
end
