module Pokepay::Response
  class UserTransaction
    def initialize(row)
      @id = row["id"]
      @user = User.new(row["user"])
      @balance = row["balance"]
      @amount = row["amount"]
      @money_amount = row["money_amount"]
      @point_amount = row["point_amount"]
      @account = Account.new(row["account"])
      @description = row["description"]
      @done_at = row["done_at"]
      @type = row["type"]
      @is_modified = row["is_modified"]
    end
    attr_reader :id
    attr_reader :user
    attr_reader :balance
    attr_reader :amount
    attr_reader :money_amount
    attr_reader :point_amount
    attr_reader :account
    attr_reader :description
    attr_reader :done_at
    attr_reader :type
    attr_reader :is_modified
  end
end
