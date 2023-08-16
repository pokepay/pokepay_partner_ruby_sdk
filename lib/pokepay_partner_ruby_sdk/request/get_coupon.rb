# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/coupon_detail"

module Pokepay::Request
  class GetCoupon < Request
    def initialize(coupon_id)
      @path = "/coupons" + "/" + coupon-id
      @method = "GET"
      @body_params = {  }
      @response_class = Pokepay::Response::CouponDetail
    end
    attr_reader :response_class
  end
end
