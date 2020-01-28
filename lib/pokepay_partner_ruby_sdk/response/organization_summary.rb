module Pokepay::Response
  class OrganizationSummary
    def initialize(row)
      @count = row["count"]
      @money_amount = row["money_amount"]
      @money_count = row["money_count"]
      @point_amount = row["point_amount"]
      @point_count = row["point_count"]
    end
    attr_reader :count
    attr_reader :money_amount
    attr_reader :money_count
    attr_reader :point_amount
    attr_reader :point_count
  end
end
