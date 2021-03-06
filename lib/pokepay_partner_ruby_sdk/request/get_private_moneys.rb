# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/paginated_private_moneys"

module Pokepay::Request
  class GetPrivateMoneys < Request
    def initialize(rest_args = {})
      @path = "/private-moneys"
      @method = "GET"
      @body_params = {  }.merge(rest_args)
      @response_class = Pokepay::Response::PaginatedPrivateMoneys
    end
    attr_reader :response_class
  end
end
