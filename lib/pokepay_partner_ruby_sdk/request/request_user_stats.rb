# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/user_stats_operation"

module Pokepay::Request
  class RequestUserStats < Request
    def initialize(from, to)
      @path = "/user-stats"
      @method = "POST"
      @body_params = { "from" => from,
                       "to" => to }
      @response_class = Pokepay::Response::UserStatsOperation
    end
    attr_reader :response_class
  end
end