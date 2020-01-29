module Pokepay::Response
  class PrivateMoneyOrganizationSummary
    def initialize(row)
      @organization_code = row["organization_code"]
      @topup = OrganizationSummary.new(row["topup"])
      @payment = OrganizationSummary.new(row["payment"])
    end
    attr_reader :organization_code
    attr_reader :topup
    attr_reader :payment
  end
end
