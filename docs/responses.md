# Responses
<a name="account-with-user"></a>
## AccountWithUser
* `id (string)`: 
* `name (string)`: 
* `is_suspended (boolean)`: 
* `status (string)`: 
* `private_money (PrivateMoney)`: 
* `user (User)`: 

`private_money`は [PrivateMoney](#private-money) オブジェクトを返します。

`user`は [User](#user) オブジェクトを返します。

<a name="account-detail"></a>
## AccountDetail
* `id (string)`: 
* `name (string)`: 
* `is_suspended (boolean)`: 
* `status (string)`: 
* `balance (double)`: 
* `money_balance (double)`: 
* `point_balance (double)`: 
* `point_debt (double)`: 
* `private_money (PrivateMoney)`: 
* `user (User)`: 
* `external_id (string)`: 

`private_money`は [PrivateMoney](#private-money) オブジェクトを返します。

`user`は [User](#user) オブジェクトを返します。

<a name="account-deleted"></a>
## AccountDeleted

<a name="bill"></a>
## Bill
* `id (string)`: 支払いQRコードのID
* `amount (double)`: 支払い額
* `max_amount (double)`: 支払い額を範囲指定した場合の上限
* `min_amount (double)`: 支払い額を範囲指定した場合の下限
* `description (string)`: 支払いQRコードの説明文(アプリ上で取引の説明文として表示される)
* `account (AccountWithUser)`: 支払いQRコード発行ウォレット
* `is_disabled (boolean)`: 無効化されているかどうか
* `token (string)`: 支払いQRコードを解析したときに出てくるURL

`account`は [AccountWithUser](#account-with-user) オブジェクトを返します。

<a name="check"></a>
## Check
* `id (string)`: チャージQRコードのID
* `created_at (string)`: チャージQRコードの作成日時
* `amount (double)`: チャージマネー額 (deprecated)
* `money_amount (double)`: チャージマネー額
* `point_amount (double)`: チャージポイント額
* `description (string)`: チャージQRコードの説明文(アプリ上で取引の説明文として表示される)
* `user (User)`: 送金元ユーザ情報
* `is_onetime (boolean)`: 使用回数が一回限りかどうか
* `is_disabled (boolean)`: 無効化されているかどうか
* `expires_at (string)`: チャージQRコード自体の失効日時
* `last_used_at (string)`: 
* `private_money (PrivateMoney)`: 対象マネー情報
* `usage_limit (integer)`: 一回限りでない場合の最大読み取り回数
* `usage_count (double)`: 一回限りでない場合の現在までに読み取られた回数
* `point_expires_at (string)`: ポイント有効期限(絶対日数指定)
* `point_expires_in_days (integer)`: ポイント有効期限(相対日数指定)
* `token (string)`: チャージQRコードを解析したときに出てくるURL

`user`は [User](#user) オブジェクトを返します。

`private_money`は [PrivateMoney](#private-money) オブジェクトを返します。

<a name="paginated-checks"></a>
## PaginatedChecks
* `rows (array of Checks)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [Check](#check) オブジェクトの配列を返します。

`pagination`は [Pagination](#pagination) オブジェクトを返します。

<a name="cpm-token"></a>
## CpmToken
* `cpm_token (string)`: 
* `account (AccountDetail)`: 
* `transaction (Transaction)`: 
* `event (ExternalTransaction)`: 
* `scopes (array of strings)`: 許可された取引種別
* `expires_at (string)`: CPMトークンの失効日時
* `metadata (string)`: エンドユーザー側メタデータ

`account`は [AccountDetail](#account-detail) オブジェクトを返します。

`transaction`は [Transaction](#transaction) オブジェクトを返します。

`event`は [ExternalTransaction](#external-transaction) オブジェクトを返します。

<a name="cashtray"></a>
## Cashtray
* `id (string)`: Cashtray自体のIDです。
* `amount (double)`: 取引金額
* `description (string)`: Cashtrayの説明文
* `account (AccountWithUser)`: 発行店舗のウォレット
* `expires_at (string)`: Cashtrayの失効日時
* `canceled_at (string)`: Cashtrayの無効化日時。NULLの場合は無効化されていません
* `token (string)`: CashtrayのQRコードを解析したときに出てくるURL

`account`は [AccountWithUser](#account-with-user) オブジェクトを返します。

<a name="cashtray-with-result"></a>
## CashtrayWithResult
* `id (string)`: CashtrayのID
* `amount (double)`: 取引金額
* `description (string)`: Cashtrayの説明文(アプリ上で取引の説明文として表示される)
* `account (AccountWithUser)`: 発行店舗のウォレット
* `expires_at (string)`: Cashtrayの失効日時
* `canceled_at (string)`: Cashtrayの無効化日時。NULLの場合は無効化されていません
* `token (string)`: CashtrayのQRコードを解析したときに出てくるURL
* `attempt (CashtrayAttempt)`: Cashtray読み取り結果
* `transaction (Transaction)`: 取引結果

`account`は [AccountWithUser](#account-with-user) オブジェクトを返します。

`attempt`は [CashtrayAttempt](#cashtray-attempt) オブジェクトを返します。

`transaction`は [Transaction](#transaction) オブジェクトを返します。

<a name="user"></a>
## User
* `id (string)`: ユーザー (または店舗) ID
* `name (string)`: ユーザー (または店舗) 名
* `is_merchant (boolean)`: 店舗ユーザーかどうか

<a name="organization"></a>
## Organization
* `code (string)`: 組織コード
* `name (string)`: 組織名

<a name="transaction-detail"></a>
## TransactionDetail
* `id (string)`: 取引ID
* `type (string)`: 取引種別
* `is_modified (boolean)`: 返金された取引かどうか
* `sender (User)`: 送金者情報
* `sender_account (Account)`: 送金ウォレット情報
* `receiver (User)`: 受取者情報
* `receiver_account (Account)`: 受取ウォレット情報
* `amount (double)`: 取引総額 (マネー額 + ポイント額)
* `money_amount (double)`: 取引マネー額
* `point_amount (double)`: 取引ポイント額(キャンペーン付与ポイント合算)
* `raw_point_amount (double)`: 取引ポイント額
* `campaign_point_amount (double)`: キャンペーンによるポイント付与額
* `done_at (string)`: 取引日時
* `description (string)`: 取引説明文
* `transfers (array of Transfers)`: 

`receiver`と`sender`は [User](#user) オブジェクトを返します。

`receiver_account`と`sender_account`は [Account](#account) オブジェクトを返します。

`transfers`は [Transfer](#transfer) オブジェクトの配列を返します。

<a name="shop-with-accounts"></a>
## ShopWithAccounts
* `id (string)`: 店舗ID
* `name (string)`: 店舗名
* `organization_code (string)`: 組織コード
* `status (string)`: 店舗の状態
* `postal_code (string)`: 店舗の郵便番号
* `address (string)`: 店舗の住所
* `tel (string)`: 店舗の電話番号
* `email (string)`: 店舗のメールアドレス
* `external_id (string)`: 店舗の外部ID
* `accounts (array of ShopAccounts)`: 

`accounts`は [ShopAccount](#shop-account) オブジェクトの配列を返します。

<a name="bulk-transaction"></a>
## BulkTransaction
* `id (string)`: 
* `request_id (string)`: リクエストID
* `name (string)`: バルク取引管理用の名前
* `description (string)`: バルク取引管理用の説明文
* `status (string)`: バルク取引の状態
* `error (string)`: バルク取引のエラー種別
* `error_lineno (integer)`: バルク取引のエラーが発生した行番号
* `submitted_at (string)`: バルク取引が登録された日時
* `updated_at (string)`: バルク取引が更新された日時

<a name="paginated-bulk-transaction-job"></a>
## PaginatedBulkTransactionJob
* `rows (array of BulkTransactionJobs)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [BulkTransactionJob](#bulk-transaction-job) オブジェクトの配列を返します。

`pagination`は [Pagination](#pagination) オブジェクトを返します。

<a name="external-transaction-detail"></a>
## ExternalTransactionDetail
* `id (string)`: ポケペイ外部取引ID
* `is_modified (boolean)`: 返金された取引かどうか
* `sender (User)`: 送金者情報
* `sender_account (Account)`: 送金ウォレット情報
* `receiver (User)`: 受取者情報
* `receiver_account (Account)`: 受取ウォレット情報
* `amount (double)`: 決済額
* `done_at (string)`: 取引日時
* `description (string)`: 取引説明文
* `transaction (TransactionDetail)`: 関連ポケペイ取引詳細

`receiver`と`sender`は [User](#user) オブジェクトを返します。

`receiver_account`と`sender_account`は [Account](#account) オブジェクトを返します。

`transaction`は [TransactionDetail](#transaction-detail) オブジェクトを返します。

<a name="paginated-private-money-organization-summaries"></a>
## PaginatedPrivateMoneyOrganizationSummaries
* `rows (array of PrivateMoneyOrganizationSummaries)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [PrivateMoneyOrganizationSummary](#private-money-organization-summary) オブジェクトの配列を返します。

`pagination`は [Pagination](#pagination) オブジェクトを返します。

<a name="private-money-summary"></a>
## PrivateMoneySummary
* `topup_amount (double)`: 
* `refunded_topup_amount (double)`: 
* `payment_amount (double)`: 
* `refunded_payment_amount (double)`: 
* `added_point_amount (double)`: 
* `topup_point_amount (double)`: 
* `campaign_point_amount (double)`: 
* `refunded_added_point_amount (double)`: 
* `exchange_inflow_amount (double)`: 
* `exchange_outflow_amount (double)`: 
* `transaction_count (integer)`: 

<a name="user-stats-operation"></a>
## UserStatsOperation
* `id (string)`: 集計処理ID
* `from (string)`: 集計期間の開始時刻
* `to (string)`: 集計期間の終了時刻
* `status (string)`: 集計処理の実行ステータス
* `error_reason (string)`: エラーとなった理由
* `done_at (string)`: 集計処理の完了時刻
* `file_url (string)`: 集計結果のCSVのダウンロードURL
* `requested_at (string)`: 集計リクエストを行った時刻

<a name="user-device"></a>
## UserDevice
* `id (string)`: デバイスID
* `user (User)`: デバイスを使用するユーザ
* `is_active (boolean)`: デバイスが有効か
* `metadata (string)`: デバイスのメタデータ

`user`は [User](#user) オブジェクトを返します。

<a name="bank-registering-info"></a>
## BankRegisteringInfo
* `redirect_url (string)`: 
* `paytree_customer_number (string)`: 

<a name="banks"></a>
## Banks
* `rows (array of Banks)`: 
* `count (integer)`: 

`rows`は [Bank](#bank) オブジェクトの配列を返します。

<a name="paginated-transaction"></a>
## PaginatedTransaction
* `rows (array of Transactions)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [Transaction](#transaction) オブジェクトの配列を返します。

`pagination`は [Pagination](#pagination) オブジェクトを返します。

<a name="paginated-transaction-v2"></a>
## PaginatedTransactionV2
* `rows (array of Transactions)`: 
* `per_page (integer)`: 
* `count (integer)`: 
* `next_page_cursor_id (string)`: 
* `prev_page_cursor_id (string)`: 

`rows`は [Transaction](#transaction) オブジェクトの配列を返します。

<a name="paginated-transfers"></a>
## PaginatedTransfers
* `rows (array of Transfers)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [Transfer](#transfer) オブジェクトの配列を返します。

`pagination`は [Pagination](#pagination) オブジェクトを返します。

<a name="paginated-transfers-v2"></a>
## PaginatedTransfersV2
* `rows (array of Transfers)`: 
* `per_page (integer)`: 
* `count (integer)`: 
* `next_page_cursor_id (string)`: 
* `prev_page_cursor_id (string)`: 

`rows`は [Transfer](#transfer) オブジェクトの配列を返します。

<a name="paginated-account-with-users"></a>
## PaginatedAccountWithUsers
* `rows (array of AccountWithUsers)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [AccountWithUser](#account-with-user) オブジェクトの配列を返します。

`pagination`は [Pagination](#pagination) オブジェクトを返します。

<a name="paginated-account-details"></a>
## PaginatedAccountDetails
* `rows (array of AccountDetails)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [AccountDetail](#account-detail) オブジェクトの配列を返します。

`pagination`は [Pagination](#pagination) オブジェクトを返します。

<a name="paginated-account-balance"></a>
## PaginatedAccountBalance
* `rows (array of AccountBalances)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [AccountBalance](#account-balance) オブジェクトの配列を返します。

`pagination`は [Pagination](#pagination) オブジェクトを返します。

<a name="paginated-shops"></a>
## PaginatedShops
* `rows (array of ShopWithMetadatas)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [ShopWithMetadata](#shop-with-metadata) オブジェクトの配列を返します。

`pagination`は [Pagination](#pagination) オブジェクトを返します。

<a name="paginated-bills"></a>
## PaginatedBills
* `rows (array of Bills)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [Bill](#bill) オブジェクトの配列を返します。

`pagination`は [Pagination](#pagination) オブジェクトを返します。

<a name="paginated-private-moneys"></a>
## PaginatedPrivateMoneys
* `rows (array of PrivateMoneys)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [PrivateMoney](#private-money) オブジェクトの配列を返します。

`pagination`は [Pagination](#pagination) オブジェクトを返します。

<a name="campaign"></a>
## Campaign
* `id (string)`: キャンペーンID
* `name (string)`: キャペーン名
* `applicable_shops (array of Users)`: キャンペーン適用対象の店舗リスト
* `is_exclusive (boolean)`: キャンペーンの重複を許すかどうかのフラグ
* `starts_at (string)`: キャンペーン開始日時
* `ends_at (string)`: キャンペーン終了日時
* `point_expires_at (string)`: キャンペーンによって付与されるポイントの失効日時
* `point_expires_in_days (integer)`: キャンペーンによって付与されるポイントの有効期限(相対指定、単位は日)
* `priority (integer)`: キャンペーンの優先順位
* `description (string)`: キャンペーン説明文
* `bear_point_shop (User)`: ポイントを負担する店舗
* `private_money (PrivateMoney)`: キャンペーンを適用するマネー
* `dest_private_money (PrivateMoney)`: ポイントを付与するマネー
* `max_total_point_amount (integer)`: 一人当たりの累計ポイント上限
* `point_calculation_rule (string)`: ポイント計算ルール (banklisp表記)
* `point_calculation_rule_object (string)`: ポイント計算ルール (JSON文字列による表記)
* `status (string)`: キャンペーンの現在の状態
* `budget_caps_amount (integer)`: キャンペーンの予算上限額
* `budget_current_amount (integer)`: キャンペーンの付与合計額
* `budget_current_time (string)`: キャンペーンの付与集計日時

`applicable-shops`は [User](#user) オブジェクトの配列を返します。

`bear_point_shop`は [User](#user) オブジェクトを返します。

`dest_private_money`と`private_money`は [PrivateMoney](#private-money) オブジェクトを返します。

<a name="paginated-campaigns"></a>
## PaginatedCampaigns
* `rows (array of Campaigns)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [Campaign](#campaign) オブジェクトの配列を返します。

`pagination`は [Pagination](#pagination) オブジェクトを返します。

<a name="account-transfer-summary"></a>
## AccountTransferSummary
* `summaries (array of AccountTransferSummaryElements)`: 

`summaries`は [AccountTransferSummaryElement](#account-transfer-summary-element) オブジェクトの配列を返します。

<a name="organization-worker-task-webhook"></a>
## OrganizationWorkerTaskWebhook
* `id (string)`: 
* `organization_code (string)`: 
* `task (string)`: 
* `url (string)`: 
* `content_type (string)`: 
* `is_active (boolean)`: 

<a name="paginated-organization-worker-task-webhook"></a>
## PaginatedOrganizationWorkerTaskWebhook
* `rows (array of OrganizationWorkerTaskWebhooks)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [OrganizationWorkerTaskWebhook](#organization-worker-task-webhook) オブジェクトの配列を返します。

`pagination`は [Pagination](#pagination) オブジェクトを返します。

<a name="coupon-detail"></a>
## CouponDetail
* `id (string)`: クーポンID
* `name (string)`: クーポン名
* `issued_shop (User)`: クーポン発行店舗
* `description (string)`: クーポンの説明文
* `discount_amount (integer)`: クーポンによる値引き額(絶対値指定)
* `discount_percentage (double)`: クーポンによる値引き率
* `discount_upper_limit (integer)`: クーポンによる値引き上限(値引き率が指定された場合の値引き上限額)
* `starts_at (string)`: クーポンの利用可能期間(開始日時)
* `ends_at (string)`: クーポンの利用可能期間(終了日時)
* `display_starts_at (string)`: クーポンの掲載期間(開始日時)
* `display_ends_at (string)`: クーポンの掲載期間(終了日時)
* `usage_limit (integer)`: ユーザごとの利用可能回数(NULLの場合は無制限)
* `min_amount (integer)`: クーポン適用可能な最小取引額
* `is_shop_specified (boolean)`: 特定店舗限定のクーポンかどうか
* `is_hidden (boolean)`: クーポン一覧に掲載されるかどうか
* `is_public (boolean)`: アプリ配信なしで受け取れるかどうか
* `code (string)`: クーポン受け取りコード
* `is_disabled (boolean)`: 無効化フラグ
* `token (string)`: クーポンを特定するためのトークン
* `coupon_image (string)`: クーポン画像のURL
* `available_shops (array of Users)`: 利用可能店舗リスト
* `private_money (PrivateMoney)`: クーポンのマネー

`issued_shop`は [User](#user) オブジェクトを返します。

`available-shops`は [User](#user) オブジェクトの配列を返します。

`private_money`は [PrivateMoney](#private-money) オブジェクトを返します。

<a name="paginated-coupons"></a>
## PaginatedCoupons
* `rows (array of Coupons)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [Coupon](#coupon) オブジェクトの配列を返します。

`pagination`は [Pagination](#pagination) オブジェクトを返します。

<a name="paginated-organizations"></a>
## PaginatedOrganizations
* `rows (array of Organizations)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [Organization](#organization) オブジェクトの配列を返します。

`pagination`は [Pagination](#pagination) オブジェクトを返します。

<a name="private-money"></a>
## PrivateMoney
* `id (string)`: マネーID
* `name (string)`: マネー名
* `unit (string)`: マネー単位 (例: 円)
* `is_exclusive (boolean)`: 会員制のマネーかどうか
* `description (string)`: マネー説明文
* `oneline_message (string)`: マネーの要約
* `organization (Organization)`: マネーを発行した組織
* `max_balance (double)`: ウォレットの上限金額
* `transfer_limit (double)`: マネーの取引上限額
* `money_topup_transfer_limit (double)`: マネーチャージ取引上限額
* `type (string)`: マネー種別 (自家型=own, 第三者型=third-party)
* `expiration_type (string)`: 有効期限種別 (チャージ日起算=static, 最終利用日起算=last-update, 最終チャージ日起算=last-topup-update)
* `enable_topup_by_member (boolean)`:  (deprecated)
* `display_money_and_point (string)`: 

`organization`は [Organization](#organization) オブジェクトを返します。

<a name="pagination"></a>
## Pagination
* `current (integer)`: 
* `per_page (integer)`: 
* `max_page (integer)`: 
* `has_prev (boolean)`: 
* `has_next (boolean)`: 

<a name="transaction"></a>
## Transaction
* `id (string)`: 取引ID
* `type (string)`: 取引種別
* `is_modified (boolean)`: 返金された取引かどうか
* `sender (User)`: 送金者情報
* `sender_account (Account)`: 送金ウォレット情報
* `receiver (User)`: 受取者情報
* `receiver_account (Account)`: 受取ウォレット情報
* `amount (double)`: 取引総額 (マネー額 + ポイント額)
* `money_amount (double)`: 取引マネー額
* `point_amount (double)`: 取引ポイント額(キャンペーン付与ポイント合算)
* `raw_point_amount (double)`: 取引ポイント額
* `campaign_point_amount (double)`: キャンペーンによるポイント付与額
* `done_at (string)`: 取引日時
* `description (string)`: 取引説明文

`receiver`と`sender`は [User](#user) オブジェクトを返します。

`receiver_account`と`sender_account`は [Account](#account) オブジェクトを返します。

<a name="external-transaction"></a>
## ExternalTransaction
* `id (string)`: ポケペイ外部取引ID
* `is_modified (boolean)`: 返金された取引かどうか
* `sender (User)`: 送金者情報
* `sender_account (Account)`: 送金ウォレット情報
* `receiver (User)`: 受取者情報
* `receiver_account (Account)`: 受取ウォレット情報
* `amount (double)`: 決済額
* `done_at (string)`: 取引日時
* `description (string)`: 取引説明文

`receiver`と`sender`は [User](#user) オブジェクトを返します。

`receiver_account`と`sender_account`は [Account](#account) オブジェクトを返します。

<a name="cashtray-attempt"></a>
## CashtrayAttempt
* `account (AccountWithUser)`: エンドユーザーのウォレット
* `status_code (double)`: ステータスコード
* `error_type (string)`: エラー型
* `error_message (string)`: エラーメッセージ
* `created_at (string)`: Cashtray読み取り記録の作成日時

`account`は [AccountWithUser](#account-with-user) オブジェクトを返します。

<a name="account"></a>
## Account
* `id (string)`: ウォレットID
* `name (string)`: ウォレット名
* `is_suspended (boolean)`: ウォレットが凍結されているかどうか
* `status (string)`: 
* `private_money (PrivateMoney)`: 設定マネー情報

`private_money`は [PrivateMoney](#private-money) オブジェクトを返します。

<a name="transfer"></a>
## Transfer
* `id (string)`: 
* `sender_account (AccountWithoutPrivateMoneyDetail)`: 
* `receiver_account (AccountWithoutPrivateMoneyDetail)`: 
* `amount (double)`: 
* `money_amount (double)`: 
* `point_amount (double)`: 
* `done_at (string)`: 
* `type (string)`: 
* `description (string)`: 
* `transaction_id (string)`: 

`receiver_account`と`sender_account`は [AccountWithoutPrivateMoneyDetail](#account-without-private-money-detail) オブジェクトを返します。

<a name="shop-account"></a>
## ShopAccount
* `id (string)`: ウォレットID
* `name (string)`: ウォレット名
* `is_suspended (boolean)`: ウォレットが凍結されているかどうか
* `can_transfer_topup (boolean)`: チャージ可能かどうか
* `private_money (PrivateMoney)`: 設定マネー情報

`private_money`は [PrivateMoney](#private-money) オブジェクトを返します。

<a name="bulk-transaction-job"></a>
## BulkTransactionJob
* `id (integer)`: 
* `bulk_transaction (BulkTransaction)`: 
* `type (string)`: 取引種別
* `sender_account_id (string)`: 
* `receiver_account_id (string)`: 
* `money_amount (double)`: 
* `point_amount (double)`: 
* `description (string)`: バルク取引ジョブ管理用の説明文
* `bear_point_account_id (string)`: 
* `point_expires_at (string)`: ポイント有効期限
* `status (string)`: バルク取引ジョブの状態
* `error (string)`: バルク取引のエラー種別
* `lineno (integer)`: バルク取引のエラーが発生した行番号
* `transaction_id (string)`: 
* `created_at (string)`: バルク取引ジョブが登録された日時
* `updated_at (string)`: バルク取引ジョブが更新された日時

`bulk_transaction`は [BulkTransaction](#bulk-transaction) オブジェクトを返します。

<a name="private-money-organization-summary"></a>
## PrivateMoneyOrganizationSummary
* `organization_code (string)`: 
* `topup (OrganizationSummary)`: 
* `payment (OrganizationSummary)`: 

`payment`と`topup`は [OrganizationSummary](#organization-summary) オブジェクトを返します。

<a name="bank"></a>
## Bank
* `id (string)`: 
* `private_money (PrivateMoney)`: 
* `bank_name (string)`: 
* `bank_code (string)`: 
* `branch_number (string)`: 
* `branch_name (string)`: 
* `deposit_type (string)`: 
* `masked_account_number (string)`: 
* `account_name (string)`: 

`private_money`は [PrivateMoney](#private-money) オブジェクトを返します。

<a name="account-balance"></a>
## AccountBalance
* `expires_at (string)`: 
* `money_amount (double)`: 
* `point_amount (double)`: 

<a name="shop-with-metadata"></a>
## ShopWithMetadata
* `id (string)`: 店舗ID
* `name (string)`: 店舗名
* `organization_code (string)`: 組織コード
* `status (string)`: 店舗の状態
* `postal_code (string)`: 店舗の郵便番号
* `address (string)`: 店舗の住所
* `tel (string)`: 店舗の電話番号
* `email (string)`: 店舗のメールアドレス
* `external_id (string)`: 店舗の外部ID

<a name="account-transfer-summary-element"></a>
## AccountTransferSummaryElement
* `transfer_type (string)`: 
* `money_amount (double)`: 
* `point_amount (double)`: 
* `count (double)`: 

<a name="coupon"></a>
## Coupon
* `id (string)`: クーポンID
* `name (string)`: クーポン名
* `issued_shop (User)`: クーポン発行店舗
* `description (string)`: クーポンの説明文
* `discount_amount (integer)`: クーポンによる値引き額(絶対値指定)
* `discount_percentage (double)`: クーポンによる値引き率
* `discount_upper_limit (integer)`: クーポンによる値引き上限(値引き率が指定された場合の値引き上限額)
* `starts_at (string)`: クーポンの利用可能期間(開始日時)
* `ends_at (string)`: クーポンの利用可能期間(終了日時)
* `display_starts_at (string)`: クーポンの掲載期間(開始日時)
* `display_ends_at (string)`: クーポンの掲載期間(終了日時)
* `usage_limit (integer)`: ユーザごとの利用可能回数(NULLの場合は無制限)
* `min_amount (integer)`: クーポン適用可能な最小取引額
* `is_shop_specified (boolean)`: 特定店舗限定のクーポンかどうか
* `is_hidden (boolean)`: クーポン一覧に掲載されるかどうか
* `is_public (boolean)`: アプリ配信なしで受け取れるかどうか
* `code (string)`: クーポン受け取りコード
* `is_disabled (boolean)`: 無効化フラグ
* `token (string)`: クーポンを特定するためのトークン

`issued_shop`は [User](#user) オブジェクトを返します。

<a name="account-without-private-money-detail"></a>
## AccountWithoutPrivateMoneyDetail
* `id (string)`: 
* `name (string)`: 
* `is_suspended (boolean)`: 
* `status (string)`: 
* `private_money_id (string)`: 
* `user (User)`: 

`user`は [User](#user) オブジェクトを返します。

<a name="organization-summary"></a>
## OrganizationSummary
* `count (integer)`: 
* `money_amount (double)`: 
* `money_count (integer)`: 
* `point_amount (double)`: 
* `raw_point_amount (double)`: 
* `campaign_point_amount (double)`: 
* `point_count (integer)`: 
