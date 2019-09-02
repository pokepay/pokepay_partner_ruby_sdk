module Pokepay::Response
  class Pagination
    def initialize(response_map)
      @current = response_map["current"]
      @per_page = response_map["per_page"]
      @max_page = response_map["max_page"]
      @has_prev = response_map["has_prev"]
      @has_next = response_map["has_next"]
    end
  end
end
