module Pokepay::Response
  class User
    def initialize(row)
      @id = row["id"]
      @name = row["name"]
      @is_merchant = row["is_merchant"]
    end
    attr_reader :id
    attr_reader :name
    attr_reader :is_merchant
  end
end