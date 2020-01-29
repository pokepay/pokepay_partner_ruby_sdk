module Pokepay::Response
  class Product
    def initialize(row)
      @jan_code = row["jan_code"]
      @name = row["name"]
      @unit_price = row["unit_price"]
      @price = row["price"]
      @is_discounted = row["is_discounted"]
      @other = row["other"]
    end
    attr_reader :jan_code
    attr_reader :name
    attr_reader :unit_price
    attr_reader :price
    attr_reader :is_discounted
    attr_reader :other
  end
end
