# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/pagination"

module Pokepay::Response
  class PaginatedChecks
    def initialize(row)
      @rows = row["rows"]
      @count = row["count"]
      @pagination = Pagination.new(row["pagination"])
    end
    attr_reader :rows
    attr_reader :count
    attr_reader :pagination
  end
end
