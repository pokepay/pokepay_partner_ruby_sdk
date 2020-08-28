# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/paginated_accounts"

module Pokepay::Request
  class ListUserAccounts < Request
    def initialize(user_id)
      @path = "/users" + "/" + user_id + "/accounts"
      @method = "GET"
      @body_params = {  }
      @response_class = Pokepay::Response::PaginatedAccounts
    end
    attr_reader :response_class
  end
end
