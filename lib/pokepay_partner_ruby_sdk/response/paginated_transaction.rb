module Pokepay::Response
  class PaginatedTransaction
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
