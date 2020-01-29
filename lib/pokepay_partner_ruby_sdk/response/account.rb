module Pokepay::Response
  class Account
    def initialize(row)
      @id = row["id"]
      @name = row["name"]
      @is_suspended = row["is_suspended"]
      @private_money = PrivateMoney.new(row["private_money"])
    end
    attr_reader :id
    attr_reader :name
    attr_reader :is_suspended
    attr_reader :private_money
  end
end
