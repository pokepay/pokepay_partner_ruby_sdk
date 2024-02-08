# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/user"

module Pokepay::Response
  class UserDevice
    def initialize(row)
      @id = row["id"]
      @user = User.new(row["user"])
      @is_active = row["is_active"]
      @metadata = row["metadata"]
    end
    attr_reader :id
    attr_reader :user
    attr_reader :is_active
    attr_reader :metadata
  end
end
