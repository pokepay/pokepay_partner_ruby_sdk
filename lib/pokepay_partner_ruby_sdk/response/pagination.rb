module Pokepay::Response
  class Pagination
    def initialize(row)
      @current = row["current"]
      @per_Page = row["per_Page"]
      @max_Page = row["max_Page"]
      @has_Prev = row["has_Prev"]
      @has_Next = row["has_Next"]
    end
    attr_reader :current
    attr_reader :per_Page
    attr_reader :max_Page
    attr_reader :has_Prev
    attr_reader :has_Next
  end
end
