# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/coupon_detail"

module Pokepay::Request
  class UpdateCoupon < Request
    def initialize(coupon_id, rest_args = {})
      @path = "/coupons" + "/" + coupon_id
      @method = "PATCH"
      @body_params = {  }.merge(rest_args)
      @response_class = Pokepay::Response::CouponDetail
    end
    attr_reader :response_class
  end
end