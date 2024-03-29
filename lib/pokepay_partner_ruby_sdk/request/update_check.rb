# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/check"

module Pokepay::Request
  class UpdateCheck < Request
    def initialize(check_id, rest_args = {})
      @path = "/checks" + "/" + check_id
      @method = "PATCH"
      @body_params = {  }.merge(rest_args)
      @response_class = Pokepay::Response::Check
    end
    attr_reader :response_class
  end
end
