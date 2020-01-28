module Pokepay::Response
  class InvalidParameters
    def initialize(row)
      @type = row["type"]
      @message = row["message"]
      @errors = row["errors"]
    end
    attr_reader :type
    attr_reader :message
    attr_reader :errors
  end
end
