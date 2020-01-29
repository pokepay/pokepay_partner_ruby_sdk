module Pokepay::Response
  class Pong
    def initialize(row)
      @ok = row["ok"]
    end
    attr_reader :ok
  end
end
