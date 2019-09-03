require "pokepay_partner_ruby_sdk/response/transaction"
require "pokepay_partner_ruby_sdk/response/pagination"

module Pokepay::Response
  class Transactions
    def initialize(res)
      @rows = res["rows"].map{|row| Transaction.new(row)}
      @count = res["count"]
      @pagination = Pagination.new(res["pagination"])
    end
    attr_reader :rows
    attr_reader :count
    attr_reader :pagination
  end
end
