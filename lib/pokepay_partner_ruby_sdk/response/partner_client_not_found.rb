# DO NOT EDIT: File is generated by code generator.


module Pokepay::Response
  class PartnerClientNotFound
    def initialize(row)
      @type = row["type"]
      @message = row["message"]
    end
    attr_reader :type
    attr_reader :message
  end
end
