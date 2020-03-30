# coding: utf-8
require "pokepay_partner_ruby_sdk"
client = Pokepay::Client.new("~/.pokepay/config.ini")

shop_id     = "8b9fbece-73fa-494d-bad5-c7fd9e52f9a0"   # 店舗ID
shop_account_id = "1e1c912d-b055-4fd7-9863-7e60a8f72f23" # 店舗アカウントID
customer_id = "78e56df5-dd71-4554-86e5-b0eb8d3781cb"   # エンドユーザーのID
customer_account_id = "c025d1cb-f5e9-47d0-b87f-f6366df26c1b" # エンドユーザーアカウントID
money_id    = "4b138a4c-8944-4f98-a5c4-96d3c1c415eb"   # 送るマネーのID

## echo
print("=== echo ==========================\n")
request = Pokepay::Request::SendEcho.new('hello')
response = client.send(request)

p response.code
# => 200

p response.body
# => {"status"=>"ok", "message"=>"hello"}

p response.object
# => #<Pokepay::Response::Echo:0x000055fd7cc0db20 @message="hello">

p response.object.message
# => "hello"

## paging

print("=== paging ==========================\n")

request = Pokepay::Request::ListTransactions.new({ "page" => 1, "per_page" => 10 })
response = client.send(request)

if response.object.pagination.has_next then
  next_page = response.object.pagination.current + 1
  request = Pokepay::Request::ListTransactions.new({ "page" => next_page, "per_page" => 10 })
  response = client.send(request)
end

## error

print("=== error ==========================\n")

request = Pokepay::Request::SendEcho.new(-1)

p response = client.send(request)
# => #<Net::HTTPBadRequest 400 Bad Request readbody=true>

p response.code
# => 400

p response.body
# => {"type"=>"invalid_parameters", "message"=>"Invalid parameters", "errors"=>{"invalid"=>["message"]}}

## get transaction

print("=== get transaction ==========================\n")

response = client.send(Pokepay::Request::GetTransaction.new(
                         "6054a1d0-35eb-4eee-ad0c-07b951b1add3" # 取引ID
                         ))

p response.object

## topup

print("=== topup ==========================\n")

response = client.send(Pokepay::Request::CreateTopupTransaction.new(
                         shop_id,     # 店舗ID
                         customer_id, # エンドユーザーのID
                         money_id,    # 送るマネーのID
                         {
                           "money_amount" => 100,            # チャージマネー額
                           "point_amount" => 200,            # チャージするポイント額 (任意)
                           "description" => "チャージテスト" # 取引履歴に表示する説明文 (任意)
                         }))

p response.object

## payment

print("=== payment ==========================\n")

response = client.send(Pokepay::Request::CreatePaymentTransaction.new(
                         shop_id,     # 店舗ID
                         customer_id, # エンドユーザーのID
                         money_id,    # 支払うマネーのID
                         100,         # 支払い額
                         {
                           "description"  => "たい焼き(小倉)" # 取引履歴に表示する説明文 (任意)
                         }))

p response.object

## create check

print("=== create check ==========================\n")

response = client.send(Pokepay::Request::CreateCheck.new(
                         shop_account_id, # 店舗アカウントID
                         {
                           "money_amount"  => 100,
                           "point_amount"  => 0
                         }))

p response.object

check_id = response.object.id

## create transaction with check

print("=== create transaction with check ==========================\n")

response = client.send(Pokepay::Request::CreateTopupTransactionWithCheck.new(
                         check_id,   # チャージ用QRコードのID
                         customer_id # エンドユーザーのID
                         ))

p response.object

## list transactions

print("=== list transactions ==========================\n")

response = client.send(Pokepay::Request::ListTransactions.new(
                         {
                           # ページング
                           "page"     => 1,
                           "per_page" => 10,

                           # フィルタオプション (すべて任意)
                           # 期間指定 (ISO8601形式の文字列)
                           "from" => "2019-01-01T00:00:00+09:00",
                           "to"   => "2020-07-30T18:13:39+09:00",

                           # 検索オプション
                           "customer_id"    => customer_id,         # エンドユーザーID
                           # "customer_name"  => "masatoi",           # エンドユーザー名
                           # "transaction_id" => "24bba30c......",    # 取引ID
                           # "shop_id"        => "456a820b......",    # 店舗ID
                           # "terminal_id"    => "d8023185......",    # 端末ID
                           # "organization"   => "pocketchange",      # 組織コード
                           "private_money_id"  => money_id,    # マネーID
                           "is_modified"    => true,              # キャンセルされた取引のみ検索するか
                           # 取引種別 (複数指定可)、チャージ=topup、支払い=payment
                           "types"          => ["topup", "payment"],
                         }))

p response.body

## add new user account

print("=== add new user account ==========================\n")

response = client.send(Pokepay::Request::CreateCustomerAccount.new(
                         money_id,
                         {
                           "user_name" => "ポケペイ太郎",
                           "account_name" => "ポケペイ太郎のアカウント"
                         }))

p response.object


## customer account detail info

print("=== customer account detail info ==========================\n")

response = client.send(Pokepay::Request::GetAccount.new(customer_account_id))

p response.object

## customer account balances

print("=== customer account balances ==========================\n")

response = client.send(Pokepay::Request::ListAccountBalances.new(customer_account_id))

p response.object
