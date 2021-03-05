# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/private_money"

module Pokepay::Response
  class ShopAccount
    def initialize(row)
      @id = row["id"]
      @name = row["name"]
      @is_suspended = row["is_suspended"]
      @can_transfer_topup = row["can_transfer_topup"]
      @private_money = PrivateMoney.new(row["private_money"])
    end
    attr_reader :id
    attr_reader :name
    attr_reader :is_suspended
    attr_reader :can_transfer_topup
    attr_reader :private_money
  end
end
