# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/paginated_coupons"

module Pokepay::Request
  class ListCoupons < Request
    def initialize(private_money_id, rest_args = {})
      @path = "/coupons"
      @method = "GET"
      @body_params = { "private_money_id" => private_money_id }.merge(rest_args)
      @response_class = Pokepay::Response::PaginatedCoupons
    end
    attr_reader :response_class
  end
end