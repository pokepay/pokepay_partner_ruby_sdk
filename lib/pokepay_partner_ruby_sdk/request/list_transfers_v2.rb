# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/paginated_transfers_v2"

module Pokepay::Request
  class ListTransfersV2 < Request
    def initialize(rest_args = {})
      @path = "/transfers-v2"
      @method = "GET"
      @body_params = {  }.merge(rest_args)
      @response_class = Pokepay::Response::PaginatedTransfersV2
    end
    attr_reader :response_class
  end
end
