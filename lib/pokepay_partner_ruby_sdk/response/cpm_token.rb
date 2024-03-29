# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/response/account_detail"
require "pokepay_partner_ruby_sdk/response/transaction"
require "pokepay_partner_ruby_sdk/response/external_transaction"

module Pokepay::Response
  class CpmToken
    def initialize(row)
      @cpm_token = row["cpm_token"]
      @account = AccountDetail.new(row["account"])
      @transaction = row["transaction"] and Transaction.new(row["transaction"])
      @event = row["event"] and ExternalTransaction.new(row["event"])
      @scopes = row["scopes"]
      @expires_at = row["expires_at"]
      @metadata = row["metadata"]
    end
    attr_reader :cpm_token
    attr_reader :account
    attr_reader :transaction
    attr_reader :event
    attr_reader :scopes
    attr_reader :expires_at
    attr_reader :metadata
  end
end
