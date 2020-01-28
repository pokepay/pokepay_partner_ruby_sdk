module Pokepay::Request
  class GetPrivateMoneyOrganizationSummaries < Request
    def initialize(private_money_id, rest_args = {})
      @path = "/private-moneys" + private_money_id + "/organization-summaries"
      @method = "GET"
      @body_params = { "private_money_id" => private_money_id }.merge(rest_args)
      @response_class = Pokepay::Response::PaginatedPrivateMoneyOrganizationSummaries
    end
    attr_reader :response_class
  end
end
