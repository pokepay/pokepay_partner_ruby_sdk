# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/user"
require "pokepay_partner_ruby_sdk/response/private_money"
require "pokepay_partner_ruby_sdk/response/private_money"

module Pokepay::Response
  class Campaign
    def initialize(row)
      @id = row["id"]
      @name = row["name"]
      @applicable_shops = row["applicable_shops"]
      @is_exclusive = row["is_exclusive"]
      @starts_at = row["starts_at"]
      @ends_at = row["ends_at"]
      @point_expires_at = row["point_expires_at"]
      @point_expires_in_days = row["point_expires_in_days"]
      @priority = row["priority"]
      @description = row["description"]
      @bear_point_shop = User.new(row["bear_point_shop"])
      @private_money = PrivateMoney.new(row["private_money"])
      @dest_private_money = PrivateMoney.new(row["dest_private_money"])
      @point_calculation_rule = row["point_calculation_rule"]
      @point_calculation_rule_object = row["point_calculation_rule_object"]
      @status = row["status"]
    end
    attr_reader :id
    attr_reader :name
    attr_reader :applicable_shops
    attr_reader :is_exclusive
    attr_reader :starts_at
    attr_reader :ends_at
    attr_reader :point_expires_at
    attr_reader :point_expires_in_days
    attr_reader :priority
    attr_reader :description
    attr_reader :bear_point_shop
    attr_reader :private_money
    attr_reader :dest_private_money
    attr_reader :point_calculation_rule
    attr_reader :point_calculation_rule_object
    attr_reader :status
  end
end