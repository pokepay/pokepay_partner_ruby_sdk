# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/user"
require "pokepay_partner_ruby_sdk/response/private_money"

module Pokepay::Response
  class Check
    def initialize(row)
      @id = row["id"]
      @created_at = row["created_at"]
      @amount = row["amount"]
      @money_amount = row["money_amount"]
      @point_amount = row["point_amount"]
      @description = row["description"]
      @user = User.new(row["user"])
      @is_onetime = row["is_onetime"]
      @is_disabled = row["is_disabled"]
      @expires_at = row["expires_at"]
      @last_used_at = row["last_used_at"]
      @private_money = PrivateMoney.new(row["private_money"])
      @usage_limit = row["usage_limit"]
      @usage_count = row["usage_count"]
      @point_expires_at = row["point_expires_at"]
      @point_expires_in_days = row["point_expires_in_days"]
      @token = row["token"]
    end
    attr_reader :id
    attr_reader :created_at
    attr_reader :amount
    attr_reader :money_amount
    attr_reader :point_amount
    attr_reader :description
    attr_reader :user
    attr_reader :is_onetime
    attr_reader :is_disabled
    attr_reader :expires_at
    attr_reader :last_used_at
    attr_reader :private_money
    attr_reader :usage_limit
    attr_reader :usage_count
    attr_reader :point_expires_at
    attr_reader :point_expires_in_days
    attr_reader :token
  end
end
