require "pokepay_partner_ruby_sdk/response/response"
require "pokepay_partner_ruby_sdk/response/transaction"
require "pokepay_partner_ruby_sdk/response/pagination"

module Pokepay::Response
  class Transactions < Response
    def initialize(response)
      super(response)
      @rows = response.body["rows"].map{|row| Transaction.new(row)}
      @count = response.body["count"]
      @pagination = Pagination.new(response.body["pagination"])
    end
    attr_reader :rows
    attr_reader :count
    attr_reader :pagination
  end
end
