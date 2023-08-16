# encoding: utf-8
# DO NOT EDIT: File is generated by code generator.

require "pokepay_partner_ruby_sdk/version"
require "pokepay_partner_ruby_sdk/client"
require "pokepay_partner_ruby_sdk/request/request"
require "pokepay_partner_ruby_sdk/response/response"
require "pokepay_partner_ruby_sdk/request/get_ping"
require "pokepay_partner_ruby_sdk/request/send_echo"
require "pokepay_partner_ruby_sdk/request/get_user"
require "pokepay_partner_ruby_sdk/request/list_user_accounts"
require "pokepay_partner_ruby_sdk/request/create_user_account"
require "pokepay_partner_ruby_sdk/request/get_account"
require "pokepay_partner_ruby_sdk/request/update_account"
require "pokepay_partner_ruby_sdk/request/delete_account"
require "pokepay_partner_ruby_sdk/request/list_account_balances"
require "pokepay_partner_ruby_sdk/request/list_account_expired_balances"
require "pokepay_partner_ruby_sdk/request/update_customer_account"
require "pokepay_partner_ruby_sdk/request/get_account_transfer_summary"
require "pokepay_partner_ruby_sdk/request/get_customer_accounts"
require "pokepay_partner_ruby_sdk/request/create_customer_account"
require "pokepay_partner_ruby_sdk/request/get_shop_accounts"
require "pokepay_partner_ruby_sdk/request/list_bills"
require "pokepay_partner_ruby_sdk/request/create_bill"
require "pokepay_partner_ruby_sdk/request/update_bill"
require "pokepay_partner_ruby_sdk/request/create_check"
require "pokepay_partner_ruby_sdk/request/get_cpm_token"
require "pokepay_partner_ruby_sdk/request/list_transactions"
require "pokepay_partner_ruby_sdk/request/create_transaction"
require "pokepay_partner_ruby_sdk/request/list_transactions_v2"
require "pokepay_partner_ruby_sdk/request/create_topup_transaction"
require "pokepay_partner_ruby_sdk/request/create_topup_transaction_with_check"
require "pokepay_partner_ruby_sdk/request/create_payment_transaction"
require "pokepay_partner_ruby_sdk/request/create_cpm_transaction"
require "pokepay_partner_ruby_sdk/request/create_transfer_transaction"
require "pokepay_partner_ruby_sdk/request/create_exchange_transaction"
require "pokepay_partner_ruby_sdk/request/bulk_create_transaction"
require "pokepay_partner_ruby_sdk/request/get_transaction"
require "pokepay_partner_ruby_sdk/request/refund_transaction"
require "pokepay_partner_ruby_sdk/request/get_transaction_by_request_id"
require "pokepay_partner_ruby_sdk/request/create_external_transaction"
require "pokepay_partner_ruby_sdk/request/refund_external_transaction"
require "pokepay_partner_ruby_sdk/request/list_transfers"
require "pokepay_partner_ruby_sdk/request/list_transfers_v2"
require "pokepay_partner_ruby_sdk/request/create_organization"
require "pokepay_partner_ruby_sdk/request/list_shops"
require "pokepay_partner_ruby_sdk/request/create_shop"
require "pokepay_partner_ruby_sdk/request/create_shop_v2"
require "pokepay_partner_ruby_sdk/request/get_shop"
require "pokepay_partner_ruby_sdk/request/update_shop"
require "pokepay_partner_ruby_sdk/request/get_private_moneys"
require "pokepay_partner_ruby_sdk/request/get_private_money_organization_summaries"
require "pokepay_partner_ruby_sdk/request/get_private_money_summary"
require "pokepay_partner_ruby_sdk/request/list_customer_transactions"
require "pokepay_partner_ruby_sdk/request/get_bulk_transaction"
require "pokepay_partner_ruby_sdk/request/list_bulk_transaction_jobs"
require "pokepay_partner_ruby_sdk/request/create_cashtray"
require "pokepay_partner_ruby_sdk/request/get_cashtray"
require "pokepay_partner_ruby_sdk/request/cancel_cashtray"
require "pokepay_partner_ruby_sdk/request/update_cashtray"
require "pokepay_partner_ruby_sdk/request/create_campaign"
require "pokepay_partner_ruby_sdk/request/list_campaigns"
require "pokepay_partner_ruby_sdk/request/get_campaign"
require "pokepay_partner_ruby_sdk/request/update_campaign"
require "pokepay_partner_ruby_sdk/request/request_user_stats"
require "pokepay_partner_ruby_sdk/request/create_webhook"
require "pokepay_partner_ruby_sdk/request/list_webhooks"
require "pokepay_partner_ruby_sdk/request/update_webhook"
require "pokepay_partner_ruby_sdk/request/list_coupons"
require "pokepay_partner_ruby_sdk/request/get_coupon"
require "pokepay_partner_ruby_sdk/response/pong"
require "pokepay_partner_ruby_sdk/response/echo"
require "pokepay_partner_ruby_sdk/response/pagination"
require "pokepay_partner_ruby_sdk/response/admin_user_with_shops_and_private_moneys"
require "pokepay_partner_ruby_sdk/response/account"
require "pokepay_partner_ruby_sdk/response/account_with_user"
require "pokepay_partner_ruby_sdk/response/account_detail"
require "pokepay_partner_ruby_sdk/response/shop_account"
require "pokepay_partner_ruby_sdk/response/account_deleted"
require "pokepay_partner_ruby_sdk/response/account_balance"
require "pokepay_partner_ruby_sdk/response/bill"
require "pokepay_partner_ruby_sdk/response/check"
require "pokepay_partner_ruby_sdk/response/cpm_token"
require "pokepay_partner_ruby_sdk/response/cashtray"
require "pokepay_partner_ruby_sdk/response/cashtray_with_result"
require "pokepay_partner_ruby_sdk/response/cashtray_attempt"
require "pokepay_partner_ruby_sdk/response/user"
require "pokepay_partner_ruby_sdk/response/private_money"
require "pokepay_partner_ruby_sdk/response/organization"
require "pokepay_partner_ruby_sdk/response/transaction"
require "pokepay_partner_ruby_sdk/response/transaction_detail"
require "pokepay_partner_ruby_sdk/response/shop_with_metadata"
require "pokepay_partner_ruby_sdk/response/shop_with_accounts"
require "pokepay_partner_ruby_sdk/response/bulk_transaction"
require "pokepay_partner_ruby_sdk/response/bulk_transaction_job"
require "pokepay_partner_ruby_sdk/response/paginated_bulk_transaction_job"
require "pokepay_partner_ruby_sdk/response/account_without_private_money_detail"
require "pokepay_partner_ruby_sdk/response/transfer"
require "pokepay_partner_ruby_sdk/response/external_transaction"
require "pokepay_partner_ruby_sdk/response/product"
require "pokepay_partner_ruby_sdk/response/organization_summary"
require "pokepay_partner_ruby_sdk/response/private_money_organization_summary"
require "pokepay_partner_ruby_sdk/response/paginated_private_money_organization_summaries"
require "pokepay_partner_ruby_sdk/response/private_money_summary"
require "pokepay_partner_ruby_sdk/response/user_stats_operation"
require "pokepay_partner_ruby_sdk/response/paginated_transaction"
require "pokepay_partner_ruby_sdk/response/paginated_transaction_v2"
require "pokepay_partner_ruby_sdk/response/paginated_transfers"
require "pokepay_partner_ruby_sdk/response/paginated_transfers_v2"
require "pokepay_partner_ruby_sdk/response/paginated_accounts"
require "pokepay_partner_ruby_sdk/response/paginated_account_with_users"
require "pokepay_partner_ruby_sdk/response/paginated_account_details"
require "pokepay_partner_ruby_sdk/response/paginated_account_balance"
require "pokepay_partner_ruby_sdk/response/paginated_shops"
require "pokepay_partner_ruby_sdk/response/paginated_bills"
require "pokepay_partner_ruby_sdk/response/paginated_private_moneys"
require "pokepay_partner_ruby_sdk/response/campaign"
require "pokepay_partner_ruby_sdk/response/paginated_campaigns"
require "pokepay_partner_ruby_sdk/response/account_transfer_summary_element"
require "pokepay_partner_ruby_sdk/response/account_transfer_summary"
require "pokepay_partner_ruby_sdk/response/organization_worker_task_webhook"
require "pokepay_partner_ruby_sdk/response/paginated_organization_worker_task_webhook"
require "pokepay_partner_ruby_sdk/response/coupon"
require "pokepay_partner_ruby_sdk/response/coupon_detail"
require "pokepay_partner_ruby_sdk/response/paginated_coupons"
require "pokepay_partner_ruby_sdk/response/bad_request"
require "pokepay_partner_ruby_sdk/response/partner_client_not_found"
require "pokepay_partner_ruby_sdk/response/partner_decryption_failed"
require "pokepay_partner_ruby_sdk/response/partner_request_expired"
require "pokepay_partner_ruby_sdk/response/partner_request_already_done"
require "pokepay_partner_ruby_sdk/response/invalid_parameters"
require "pokepay_partner_ruby_sdk/response/unpermitted_admin_user"
require "pokepay_partner_ruby_sdk/response/user_stats_operation_service_unavailable"

module Pokepay
  class Error < StandardError; end
end
