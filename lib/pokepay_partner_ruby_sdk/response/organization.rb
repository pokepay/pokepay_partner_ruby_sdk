module Pokepay::Response
  class Organization
    def initialize(row)
      @code = row["code"]
      @name = row["name"]
    end
    attr_reader :code
    attr_reader :name
  end
end