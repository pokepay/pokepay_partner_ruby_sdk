module Pokepay::Response
  class AdminUserWithShopsAndPrivateMoneys
    def initialize(row)
      @id = row["id"]
      @role = row["role"]
      @email = row["email"]
      @name = row["name"]
      @is_active = row["is_active"]
      @organization = Organization.new(row["organization"])
      @shops = row["shops"]
      @private_moneys = row["private_moneys"]
    end
    attr_reader :id
    attr_reader :role
    attr_reader :email
    attr_reader :name
    attr_reader :is_active
    attr_reader :organization
    attr_reader :shops
    attr_reader :private_moneys
  end
end
