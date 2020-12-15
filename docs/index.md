# Partner API SDK for Ruby
## Installation

rubygemsからインストールすることができます。
```
$ gem install pokepay_partner_ruby_sdk
```

ロードパスの通ったところにライブラリが配置されていれば、以下のようにロードできます。

```ruby
require "pokepay_partner_ruby_sdk"
```

## Getting started

基本的な使い方は次のようになります。

- ライブラリをロード
- 設定ファイル(後述)から `Pokepay::Client` オブジェクトを作る
- リクエストオブジェクトを作り、`Pokepay::Client` オブジェクトの `send` メソッドに対して渡す
- レスポンスオブジェクトを得る

```ruby
require "pokepay_partner_ruby_sdk"
client = Pokepay::Client.new("/path/to/config.ini")
request = Pokepay::Request::SendEcho.new('hello')
response = client.send(request)
```

レスポンスオブジェクト内にステータスコード、JSONをパースしたハッシュマップ、さらにレスポンス内容のオブジェクトが含まれています。

## Settings

設定はINIファイルに記述し、`Pokepay::Client` のコンストラクタにファイルパスを指定します。

SDKプロジェクトルートに `config.ini.sample` というファイルがありますのでそれを元に必要な情報を記述してください。特に以下の情報は通信の安全性のため必要な項目です。これらはパートナー契約時にお渡ししているものです。

- `CLIENT_ID`: パートナーAPI クライアントID
- `CLIENT_SECRET`: パートナーAPI クライアント秘密鍵
- `SSL_KEY_FILE`: SSL秘密鍵ファイルパス
- `SSL_CERT_FILE`: SSL証明書ファイルパス

この他に接続先のサーバURL情報が必要です。

- `API_BASE_URL`: パートナーAPI サーバURL

また、この設定ファイルには認証に必要な情報が含まれるため、ファイルの管理・取り扱いに十分注意してください。

設定ファイル記述例(`config.ini.sample`)

```
CLIENT_ID        = xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
CLIENT_SECRET    = yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
API_BASE_URL     = https://partnerapi-sandbox.pokepay.jp
SSL_KEY_FILE     = /path/to/key.pem
SSL_CERT_FILE    = /path/to/cert.pem
```

## Overview

### APIリクエスト

Partner APIへの通信はリクエストオブジェクトを作り、`Pokepay::Client.send` メソッドに渡すことで行われます。  
リクエストクラスは名前空間 `Pokepay::Request` 以下に定義されています。

たとえば `Pokepay::Request::SendEcho` は送信した内容をそのまま返す処理です。

```ruby
request = Pokepay::Request::SendEcho.new('hello')

response = client.send(request)
# => #<Pokepay::Response::Response 200 OK readbody=>
```

通信の結果として、レスポンスオブジェクトが得られます。  
これはステータスコードとレスポンスボディ、各レスポンスクラスのオブジェクトをインスタンス変数に持つオブジェクトです。

```ruby
response.code
# => 200

response.body
# => {"status"=>"ok", "message"=>"hello"}

response.object
# => #<Pokepay::Response::Echo:0x000055fd7cc0db20 @message="hello">

response.object.message
# => "hello"
```

利用可能なAPI操作については [API Operations](#api-operations) で紹介します。

<a name="paging"></a>
### ページング

API操作によっては、大量のデータがある場合に備えてページング処理があります。
その処理では以下のようなプロパティを持つレスポンスオブジェクトを返します。

- rows : 列挙するレスポンスクラスのオブジェクトの配列
- count : 全体の要素数
- pagination : 以下のインスタンス変数を持つオブジェクト
  - current : 現在のページ位置(1からスタート)
  - per_page : 1ページ当たりの要素数
  - max_page : 最後のページ番号
  - has_prev : 前ページを持つかどうかの真理値
  - has_next : 次ページを持つかどうかの真理値

ページングクラスは `Pokepay::Response::Pagination` で定義されています。

以下にコード例を示します。

```ruby
request = Pokepay::Request::ListTransactions.new({ "page" => 1, "per_page" => 50 })
response = client.send(request)

if response.object.pagination.has_next then
  next_page = response.object.pagination.current + 1
  request = Pokepay::Request::ListTransactions.new({ "page" => next_page, "per_page" => 50 })
  response = client.send(request)
end
```

### エラーハンドリング

エラーの場合は `Net::HTTPBadRequest` などのエラーレスポンスオブジェクトが返ります。  
エラーレスポンスもステータスコードとレスポンスボディを持ちます。

```ruby
request = Pokepay::Request::SendEcho.new(-1)

response = client.send(request)
# => #<Net::HTTPBadRequest 400 Bad Request readbody=true>

response.code
# => 400

response.body
# => {"type"=>"invalid_parameters", "message"=>"Invalid parameters", "errors"=>{"invalid"=>["message"]}}
```
<a name="api-operations"></a>
## API Operations

- [ListTransfers](#list-transfers): 
- [GetTransaction](#get-transaction): 取引情報を取得する
- [CreateExchangeTransaction](#create-exchange-transaction): 
- [CreateTransferTransaction](#create-transfer-transaction): 個人間送金
- [CreatePaymentTransaction](#create-payment-transaction): 支払いする
- [CreateTopupTransaction](#create-topup-transaction): チャージする
- [CreateTransaction](#create-transaction): 
- [ListTransactions](#list-transactions): 取引履歴を取得する
- [CreateTopupTransactionWithCheck](#create-topup-transaction-with-check): チャージQRコードを読み取ることでチャージする
- [UpdateBill](#update-bill): 支払いQRコードの更新
- [CreateBill](#create-bill): 支払いQRコードの発行
- [ListBills](#list-bills): 支払いQRコード一覧を表示する
- [ListCustomerTransactions](#list-customer-transactions): 取引履歴を取得する
- [CreateCustomerAccount](#create-customer-account): 新規エンドユーザーウォレットを追加する
- [ListAccountExpiredBalances](#list-account-expired-balances): エンドユーザーの失効済みの残高内訳を表示する
- [ListAccountBalances](#list-account-balances): エンドユーザーの残高内訳を表示する
- [UpdateAccount](#update-account): ウォレット情報を更新する
- [GetAccount](#get-account): ウォレット情報を表示する
- [CreateShop](#create-shop): 新規店舗を追加する
- [ListShops](#list-shops): 店舗一覧を取得する
- [ListUserAccounts](#list-user-accounts): エンドユーザー、店舗ユーザーのウォレット一覧を表示する
- [GetPrivateMoneyOrganizationSummaries](#get-private-money-organization-summaries): 決済加盟店の取引サマリを取得する
- [BulkCreateTransaction](#bulk-create-transaction): CSVファイル一括取引
### Transaction
<a name="list-transfers"></a>
#### 
```ruby
response = $client.send(Pokepay::Request::ListTransfers.new(
                          from: "2025-01-05T04:45:16.000000+09:00",
                          to: "2017-12-05T11:36:12.000000+09:00",
                          page: 608,
                          per_page: 7126,
                          shop_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                          shop_name: "msWBTf3SfgLVNlOhNoRUioebBno3HZhnyNZ5Q77U04aLs4hmy4C28WnCRfz2leovb1R7O6QOgboW2zpcaLxa2QZma6CRo8nyJO9Y",
                          customer_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                          customer_name: "f9djMgk8QSZwJ1udEIb7zDJ6KZTEk0mDRGqd8jGihF2zo2GN3QYD",
                          transaction_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                          private_money_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                          is_modified: false,
                          transaction_types: ["exchange", "payment", "topup", "transfer"],
                          transfer_types: ["payment", "transfer"]
))
```
成功したときは[PaginatedTransfers](#paginated-transfers)オブジェクトを返します
<a name="get-transaction"></a>
#### 取引情報を取得する
取引を取得します。
```ruby
response = $client.send(Pokepay::Request::GetTransaction.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"                # transaction_id: 取引ID
))
```

---
`transaction_id`  
取引IDです。

フィルターとして使われ、指定した取引IDの取引を取得します。

---
成功したときは[Transaction](#transaction)オブジェクトを返します
<a name="create-exchange-transaction"></a>
#### 
```ruby
response = $client.send(Pokepay::Request::CreateExchangeTransaction.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                          1703,
                          description: "CZS1PVe5LZzi2NmWBluHrzflOytNd3ROmH9nMfAHn"
))
```
成功したときは[Transaction](#transaction)オブジェクトを返します
<a name="create-transfer-transaction"></a>
#### 個人間送金
エンドユーザー間での送金取引(個人間送金)を作成します。
個人間送金で送れるのはマネーのみで、ポイントを送ることはできません。送金元のマネー残高のうち、有効期限が最も遠いものから順に送金されます。

```ruby
response = $client.send(Pokepay::Request::CreateTransferTransaction.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # sender_id: 送金元ユーザーID
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # receiver_id: 受取ユーザーID
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # private_money_id: マネーID
                          6547,                                                 # amount: 送金額
                          description: "たい焼き(小倉)"                               # 取引履歴に表示する説明文
))
```

---
`sender_id`  
エンドユーザーIDです。

送金元のエンドユーザー(送り主)を指定します。

---
`receiver_id`  
エンドユーザーIDです。

送金先のエンドユーザー(受け取り人)を指定します。

---
`private_money_id`  
マネーIDです。

マネーを指定します。

---
`amount`  
マネー額です。

送金するマネー額を指定します。

---
`description`  
取引説明文です。

任意入力で、取引履歴に表示される説明文です。

---
成功したときは[Transaction](#transaction)オブジェクトを返します
<a name="create-payment-transaction"></a>
#### 支払いする
支払取引を作成します。
支払い時には、エンドユーザーの残高のうち、ポイント残高から優先的に消費されます。

```ruby
response = $client.send(Pokepay::Request::CreatePaymentTransaction.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # shop_id: 店舗ID
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # customer_id: エンドユーザーID
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # private_money_id: マネーID
                          6735,                                                 # amount: 支払い額
                          description: "たい焼き(小倉)"                               # 取引履歴に表示する説明文
))
```

---
`shop_id`  
店舗IDです。

送金先の店舗を指定します。

---
`customer_id`  
エンドユーザーIDです。

送金元のエンドユーザーを指定します。

---
`private_money_id`  
マネーIDです。

マネーを指定します。

---
`amount`  
マネー額です。

送金するマネー額を指定します。

---
`description`  
取引説明文です。

任意入力で、取引履歴に表示される説明文です。

---
成功したときは[Transaction](#transaction)オブジェクトを返します
<a name="create-topup-transaction"></a>
#### チャージする
チャージ取引を作成します。
```ruby
response = $client.send(Pokepay::Request::CreateTopupTransaction.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # shop_id: 店舗ID
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # customer_id: エンドユーザーのID
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # private_money_id: マネーID
                          bear_point_shop_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # ポイント支払時の負担店舗ID
                          money_amount: 4261,                                   # マネー額
                          point_amount: 3664,                                   # ポイント額
                          point_expires_at: "2016-08-30T06:01:57.000000+09:00", # ポイント有効期限
                          description: "初夏のチャージキャンペーン"                          # 取引履歴に表示する説明文
))
```

---
`shop_id`  
店舗IDです。

送金元の店舗を指定します。

---
`customer_id`  
エンドユーザーIDです。

送金先のエンドユーザーを指定します。

---
`private_money_id`  
マネーIDです。

マネーを指定します。

---
`bear_point_shop_id`  
ポイント支払時の負担店舗IDです。

ポイント支払い時に実際お金を負担する店舗を指定します。

---
`money_amount`  
マネー額です。

送金するマネー額を指定します。

---
`point_amount`  
ポイント額です。

送金するポイント額を指定します。

---
`point_expires_at`  
ポイントをチャージした場合の、付与されるポイントの有効期限です。
省略した場合はマネーに設定された有効期限と同じものがポイントの有効期限となります。

---
`description`  
取引説明文です。

任意入力で、取引履歴に表示される説明文です。

---
成功したときは[Transaction](#transaction)オブジェクトを返します
<a name="create-transaction"></a>
#### 
```ruby
response = $client.send(Pokepay::Request::CreateTransaction.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                          money_amount: 8060,
                          point_amount: 204,
                          point_expires_at: "2022-01-30T13:09:04.000000+09:00", # ポイント有効期限
                          description: "jrt4CFESWJnPCLUxGLtrgoghS3pPHE574eeX1ksH4R2MgyW6z149JBRZmQUgzecqWdDVSstoEtPVoykbtA6l7WDayqQLAKXyhWYdlIHfSBBKI1KQl4cK6HLesoN7AsxjaX4bkzoW5SSzFCKjOEE829PJZq44v95w5O"
))
```

---
`point_expires_at`  
ポイントをチャージした場合の、付与されるポイントの有効期限です。
省略した場合はマネーに設定された有効期限と同じものがポイントの有効期限となります。

---
成功したときは[Transaction](#transaction)オブジェクトを返します
<a name="list-transactions"></a>
#### 取引履歴を取得する
取引一覧を返します。
```ruby
response = $client.send(Pokepay::Request::ListTransactions.new(
                          from: "2025-01-30T08:50:36.000000+09:00",             # 開始日時
                          to: "2017-10-21T12:41:10.000000+09:00",               # 終了日時
                          page: 1,                                              # ページ番号
                          per_page: 50,                                         # 1ページ分の取引数
                          shop_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",      # 店舗ID
                          customer_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",  # エンドユーザーID
                          customer_name: "太郎",                                  # エンドユーザー名
                          terminal_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",  # 端末ID
                          transaction_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # 取引ID
                          organization_code: "pocketchange",                    # 組織コード
                          private_money_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # マネーID
                          is_modified: false,                                   # キャンセルフラグ
                          types: ["topup", "payment"]                           # 取引種別 (複数指定可)、チャージ=topup、支払い=payment
))
```

---
`from`  
抽出期間の開始日時です。

フィルターとして使われ、開始日時以降に発生した取引のみ一覧に表示されます。

---
`to`  
抽出期間の終了日時です。

フィルターとして使われ、終了日時以前に発生した取引のみ一覧に表示されます。

---
`page`  
取得したいページ番号です。

---
`per_page`  
1ページ分の取引数です。

---
`shop_id`  
店舗IDです。

フィルターとして使われ、指定された店舗での取引のみ一覧に表示されます。

---
`customer_id`  
エンドユーザーIDです。

フィルターとして使われ、指定されたエンドユーザーでの取引のみ一覧に表示されます。

---
`customer_name`  
エンドユーザー名です。

フィルターとして使われ、入力された名前に部分一致するエンドユーザーでの取引のみ一覧に表示されます。

---
`terminal_id`  
端末IDです。

フィルターとして使われ、指定された端末での取引のみ一覧に表示されます。

---
`transaction_id`  
取引IDです。

フィルターとして使われ、指定された取引のみ一覧に表示されます。

---
`organization_code`  
組織コードです。

フィルターとして使われ、指定された組織での取引のみ一覧に表示されます。

---
`private_money_id`  
マネーIDです。

フィルターとして使われ、指定したマネーでの取引のみ一覧に表示されます。

---
`is_modified`  
キャンセルフラグです。

これにtrueを指定するとキャンセルされた取引のみ一覧に表示されます。
デフォルト値はfalseで、キャンセルの有無にかかわらず一覧に表示されます。

---
`types`  
取引の種類でフィルターします。

以下の種類を指定できます。

1. topup
   店舗からエンドユーザーへの送金取引(チャージ)

2. payment
   エンドユーザーから店舗への送金取引(支払い)

3. exchange-outflow
　　他マネーへの流出

4. exchange-inflow
   他マネーからの流入

---
成功したときは[PaginatedTransaction](#paginated-transaction)オブジェクトを返します
### Check
店舗ユーザが発行し、エンドユーザがポケペイアプリから読み取ることでチャージ取引が発生するQRコードです。

チャージQRコードを解析すると次のようなURLになります(URLは環境によって異なります)。

`https://www-sandbox.pokepay.jp/checks/xxxxxxxx-xxxx-xxxxxxxxx-xxxxxxxxxxxx`

QRコードを読み取る方法以外にも、このURLリンクを直接スマートフォン(iOS/Android)上で開くことによりアプリが起動して取引が行われます。(注意: 上記URLはsandbox環境であるため、アプリもsandbox環境のものである必要があります) 上記URL中の `xxxxxxxx-xxxx-xxxxxxxxx-xxxxxxxxxxxx` の部分がチャージQRコードのIDです。

<a name="create-topup-transaction-with-check"></a>
#### チャージQRコードを読み取ることでチャージする
通常チャージQRコードはエンドユーザのアプリによって読み取られ、アプリとポケペイサーバとの直接通信によって取引が作られます。 もしエンドユーザとの通信をパートナーのサーバのみに限定したい場合、パートナーのサーバがチャージQRの情報をエンドユーザから代理受けして、サーバ間連携APIによって実際のチャージ取引をリクエストすることになります。

エンドユーザから受け取ったチャージ用QRコードのIDをエンドユーザIDと共に渡すことでチャージ取引が作られます。

```ruby
response = $client.send(Pokepay::Request::CreateTopupTransactionWithCheck.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # check_id: チャージ用QRコードのID
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"                # customer_id: エンドユーザーのID
))
```

---
`check_id`  
チャージ用QRコードのIDです。

QRコード生成時に送金元店舗のウォレット情報や、送金額などが登録されています。

---
`customer_id`  
エンドユーザーIDです。

送金先のエンドユーザーを指定します。

---
成功したときは[Transaction](#transaction)オブジェクトを返します
### Bill
支払いQRコード
<a name="update-bill"></a>
#### 支払いQRコードの更新
支払いQRコードの内容を更新します。パラメータは全て省略可能で、指定したもののみ更新されます。
```ruby
response = $client.send(Pokepay::Request::UpdateBill.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # bill_id: 支払いQRコードのID
                          amount: 4723,                                         # 支払い額
                          description: "test bill",                             # 説明文
                          is_disabled: false                                    # 無効化されているかどうか
))
```

---
`bill_id`  
更新対象の支払いQRコードのIDです。

---
`amount`  
支払いQRコードを支払い額を指定します。nullを渡すと任意金額の支払いQRコードとなり、エンドユーザーがアプリで読み取った際に金額を入力します。

---
`description`  
支払いQRコードの詳細説明文です。アプリ上で取引の説明文として表示されます。

---
`is_disabled`  
支払いQRコードが無効化されているかどうかを指定します。真にすると無効化され、偽にすると有効化します。

---
成功したときは[Bill](#bill)オブジェクトを返します
<a name="create-bill"></a>
#### 支払いQRコードの発行
支払いQRコードの内容を更新します。支払い先の店舗ユーザーは指定したマネーのウォレットを持っている必要があります。
```ruby
response = $client.send(Pokepay::Request::CreateBill.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # private_money_id: 支払いマネーのマネーID
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # shop_id: 支払い先(受け取り人)の店舗ID
                          amount: 2253,                                         # 支払い額
                          description: "test bill"                              # 説明文(アプリ上で取引の説明文として表示される)
))
```

---
`amount`  
支払いQRコードを支払い額を指定します。省略するかnullを渡すと任意金額の支払いQRコードとなり、エンドユーザーがアプリで読み取った際に金額を入力します。

---
成功したときは[Bill](#bill)オブジェクトを返します
<a name="list-bills"></a>
#### 支払いQRコード一覧を表示する
支払いQRコード一覧を表示します。
```ruby
response = $client.send(Pokepay::Request::ListBills.new(
                          page: 6964,                                           # ページ番号
                          per_page: 646,                                        # 1ページの表示数
                          bill_id: "xdWcd35lzG",                                # 支払いQRコードのID
                          private_money_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # マネーID
                          organization_code: "--6",                             # 組織コード
                          description: "test bill",                             # 取引説明文
                          created_from: "2021-12-09T08:25:09.000000+09:00",     # 作成日時(起点)
                          created_to: "2024-06-02T00:20:08.000000+09:00",       # 作成日時(終点)
                          shop_name: "bill test shop1",                         # 店舗名
                          shop_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",      # 店舗ID
                          lower_limit_amount: 4277,                             # 金額の範囲によるフィルタ(下限)
                          upper_limit_amount: 8641,                             # 金額の範囲によるフィルタ(上限)
                          is_disabled: true                                     # 支払いQRコードが無効化されているかどうか
))
```

---
`page`  
取得したいページ番号です。

---
`per_page`  
1ページに表示する支払いQRコードの数です。

---
`bill_id`  
支払いQRコードのIDを指定して検索します。IDは前方一致で検索されます。

---
`private_money_id`  
支払いQRコードの送金元ウォレットのマネーIDでフィルターします。

---
`organization_code`  
支払いQRコードの送金元店舗が所属する組織の組織コードでフィルターします。

---
`description`  
支払いQRコードを読み取ることで作られた取引の説明文としてアプリなどに表示されます。

---
`created_from`  
支払いQRコードの作成日時でフィルターします。

これ以降に作成された支払いQRコードのみ一覧に表示されます。

---
`created_to`  
支払いQRコードの作成日時でフィルターします。

これ以前に作成された支払いQRコードのみ一覧に表示されます。

---
`shop_name`  
支払いQRコードを作成した店舗名でフィルターします。店舗名は部分一致で検索されます。

---
`shop_id`  
支払いQRコードを作成した店舗IDでフィルターします。

---
`lower_limit_amount`  
支払いQRコードの金額の下限を指定してフィルターします。

---
`upper_limit_amount`  
支払いQRコードの金額の上限を指定してフィルターします。

---
`is_disabled`  
支払いQRコードが無効化されているかどうかを表します。デフォルト値は偽(有効)です。

---
成功したときは[PaginatedBills](#paginated-bills)オブジェクトを返します
### Customer
<a name="list-customer-transactions"></a>
#### 取引履歴を取得する
取引一覧を返します。
```ruby
response = $client.send(Pokepay::Request::ListCustomerTransactions.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # private_money_id: マネーID
                          sender_customer_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # 送金エンドユーザーID
                          receiver_customer_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # 受取エンドユーザーID
                          type: "SiRG2UPRPU",                                   # 取引種別、チャージ=topup、支払い=payment、個人間送金=transfer
                          is_modified: true,                                    # キャンセル済みかどうか
                          from: "2023-10-10T03:17:28.000000+09:00",             # 開始日時
                          to: "2016-01-13T03:27:33.000000+09:00",               # 終了日時
                          page: 1,                                              # ページ番号
                          per_page: 50                                          # 1ページ分の取引数
))
```

---
`private_money_id`  
マネーIDです。
フィルターとして使われ、指定したマネーでの取引のみ一覧に表示されます。

---
`sender_customer_id`  
送金ユーザーIDです。

フィルターとして使われ、指定された送金ユーザーでの取引のみ一覧に表示されます。

---
`receiver_customer_id`  
受取ユーザーIDです。

フィルターとして使われ、指定された受取ユーザーでの取引のみ一覧に表示されます。

---
`type`  
取引の種類でフィルターします。

以下の種類を指定できます。

1. topup
   店舗からエンドユーザーへの送金取引(チャージ)
2. payment
   エンドユーザーから店舗への送金取引(支払い)
3. exchange
   他マネーへの流出(outflow)/他マネーからの流入(inflow)
4. transfer
   個人間送金

---
`is_modified`  
キャンセル済みかどうかを判定するフラグです。

これにtrueを指定するとキャンセルされた取引のみ一覧に表示されます。
falseを指定するとキャンセルされていない取引のみ一覧に表示されます
何も指定しなければキャンセルの有無にかかわらず一覧に表示されます。

---
`from`  
抽出期間の開始日時です。

フィルターとして使われ、開始日時以降に発生した取引のみ一覧に表示されます。

---
`to`  
抽出期間の終了日時です。

フィルターとして使われ、終了日時以前に発生した取引のみ一覧に表示されます。

---
`page`  
取得したいページ番号です。

---
`per_page`  
1ページ分の取引数です。

---
成功したときは[PaginatedTransaction](#paginated-transaction)オブジェクトを返します
<a name="create-customer-account"></a>
#### 新規エンドユーザーウォレットを追加する
指定したマネーのウォレットを作成し、同時にそのウォレットを保有するユーザも作成します。
```ruby
response = $client.send(Pokepay::Request::CreateCustomerAccount.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # private_money_id: マネーID
                          user_name: "ポケペイ太郎",                                  # ユーザー名
                          account_name: "ポケペイ太郎のアカウント"                          # アカウント名
))
```

---
`private_money_id`  
マネーIDです。

これによって作成するウォレットのマネーを指定します。

---
`user_name`  
ウォレットと共に作成するユーザ名です。省略した場合は空文字となります。

---
`account_name`  
作成するウォレット名です。省略した場合は空文字となります。

---
成功したときは[AccountWithUser](#account-with-user)オブジェクトを返します
<a name="list-account-expired-balances"></a>
#### エンドユーザーの失効済みの残高内訳を表示する
エンドユーザーのウォレット毎の失効済みの残高を有効期限別のリストとして取得します。
```ruby
response = $client.send(Pokepay::Request::ListAccountExpiredBalances.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # account_id: ウォレットID
                          page: 7693,                                           # ページ番号
                          per_page: 1912,                                       # 1ページ分の取引数
                          expires_at_from: "2019-01-21T09:18:18.000000+09:00",  # 有効期限の期間によるフィルター(開始時点)
                          expires_at_to: "2024-12-06T21:23:18.000000+09:00",    # 有効期限の期間によるフィルター(終了時点)
                          direction: "desc"                                     # 有効期限によるソート順序
))
```

---
`account_id`  
ウォレットIDです。

フィルターとして使われ、指定したウォレットIDのウォレット残高を取得します。

---
`page`  
取得したいページ番号です。デフォルト値は1です。

---
`per_page`  
1ページ分のウォレット残高数です。デフォルト値は30です。

---
`expires_at_from`  
有効期限の期間によるフィルターの開始時点のタイムスタンプです。デフォルトでは未指定です。

---
`expires_at_to`  
有効期限の期間によるフィルターの終了時点のタイムスタンプです。デフォルトでは未指定です。

---
`direction`  
有効期限によるソートの順序を指定します。デフォルト値はdesc (降順)です。

---
成功したときは[PaginatedAccountBalance](#paginated-account-balance)オブジェクトを返します
<a name="list-account-balances"></a>
#### エンドユーザーの残高内訳を表示する
エンドユーザーのウォレット毎の残高を有効期限別のリストとして取得します。
```ruby
response = $client.send(Pokepay::Request::ListAccountBalances.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # account_id: ウォレットID
                          page: 780,                                            # ページ番号
                          per_page: 6531,                                       # 1ページ分の取引数
                          expires_at_from: "2023-06-07T17:07:23.000000+09:00",  # 有効期限の期間によるフィルター(開始時点)
                          expires_at_to: "2018-04-17T03:52:40.000000+09:00",    # 有効期限の期間によるフィルター(終了時点)
                          direction: "desc"                                     # 有効期限によるソート順序
))
```

---
`account_id`  
ウォレットIDです。

フィルターとして使われ、指定したウォレットIDのウォレット残高を取得します。

---
`page`  
取得したいページ番号です。デフォルト値は1です。

---
`per_page`  
1ページ分のウォレット残高数です。デフォルト値は30です。

---
`expires_at_from`  
有効期限の期間によるフィルターの開始時点のタイムスタンプです。デフォルトでは未指定です。

---
`expires_at_to`  
有効期限の期間によるフィルターの終了時点のタイムスタンプです。デフォルトでは未指定です。

---
`direction`  
有効期限によるソートの順序を指定します。デフォルト値はasc (昇順)です。

---
成功したときは[PaginatedAccountBalance](#paginated-account-balance)オブジェクトを返します
<a name="update-account"></a>
#### ウォレット情報を更新する
ウォレットの状態を更新します。現在はウォレットの凍結/凍結解除の切り替えにのみ対応しています。
```ruby
response = $client.send(Pokepay::Request::UpdateAccount.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # account_id: ウォレットID
                          is_suspended: true                                    # ウォレットが凍結されているかどうか
))
```

---
`account_id`  
ウォレットIDです。

指定したウォレットIDのウォレットの状態を更新します。

---
`is_suspended`  
ウォレットの凍結状態です。真にするとウォレットが凍結され、そのウォレットでは新規取引ができなくなります。偽にすると凍結解除されます。

---
成功したときは[AccountDetail](#account-detail)オブジェクトを返します
<a name="get-account"></a>
#### ウォレット情報を表示する
ウォレットを取得します。
```ruby
response = $client.send(Pokepay::Request::GetAccount.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"                # account_id: ウォレットID
))
```

---
`account_id`  
ウォレットIDです。

フィルターとして使われ、指定したウォレットIDのウォレットを取得します。

---
成功したときは[AccountDetail](#account-detail)オブジェクトを返します
### Organization
### Shop
<a name="create-shop"></a>
#### 新規店舗を追加する
```ruby
response = $client.send(Pokepay::Request::CreateShop.new(
                          "oxスーパー三田店",                                          # shop_name: 店舗名
                          shop_postal_code: "854-5207",                         # 店舗の郵便番号
                          shop_address: "東京都港区芝...",                            # 店舗の住所
                          shop_tel: "0518138-8884",                             # 店舗の電話番号
                          shop_email: "SFyNtopqI6@bCrD.com",                    # 店舗のメールアドレス
                          shop_external_id: "gQTi",                             # 店舗の外部ID
                          organization_code: "ox-supermarket"                   # 組織コード
))
```
成功したときは[User](#user)オブジェクトを返します
<a name="list-shops"></a>
#### 店舗一覧を取得する
```ruby
response = $client.send(Pokepay::Request::ListShops.new(
                          organization_code: "pocketchange",                    # 組織コード
                          private_money_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # マネーID
                          name: "oxスーパー三田店",                                    # 店舗名
                          postal_code: "2880587",                               # 店舗の郵便番号
                          address: "東京都港区芝...",                                 # 店舗の住所
                          tel: "061-804295",                                    # 店舗の電話番号
                          email: "zqDmxXKufP@IjjJ.com",                         # 店舗のメールアドレス
                          external_id: "zSXKPSRMVYMVxniANdM0yy6srR",            # 店舗の外部ID
                          page: 1,                                              # ページ番号
                          per_page: 50                                          # 1ページ分の取引数
))
```

---
`organization_code`  
このパラメータを渡すとその組織の店舗のみが返され、省略すると加盟店も含む店舗が返されます。


---
`private_money_id`  
このパラメータを渡すとそのマネーのウォレットを持つ店舗のみが返されます。


---
`name`  
このパラメータを渡すとその名前の店舗のみが返されます。


---
`postal_code`  
このパラメータを渡すとその郵便番号が登録された店舗のみが返されます。


---
`address`  
このパラメータを渡すとその住所が登録された店舗のみが返されます。


---
`tel`  
このパラメータを渡すとその電話番号が登録された店舗のみが返されます。


---
`email`  
このパラメータを渡すとそのメールアドレスが登録された店舗のみが返されます。


---
`external_id`  
このパラメータを渡すとその外部IDが登録された店舗のみが返されます。


---
`page`  
取得したいページ番号です。

---
`per_page`  
1ページ分の取引数です。

---
成功したときは[PaginatedShops](#paginated-shops)オブジェクトを返します
### Account
<a name="list-user-accounts"></a>
#### エンドユーザー、店舗ユーザーのウォレット一覧を表示する
ユーザーIDを指定してそのユーザーのウォレット一覧を取得します。
```ruby
response = $client.send(Pokepay::Request::ListUserAccounts.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"                # user_id: ユーザーID
))
```

---
`user_id`  
ユーザーIDです。

指定したユーザーIDのウォレット一覧を取得します。パートナーキーと紐づく組織が発行しているマネーのウォレットのみが表示されます。

---
成功したときは[PaginatedAccounts](#paginated-accounts)オブジェクトを返します
### Private Money
<a name="get-private-money-organization-summaries"></a>
#### 決済加盟店の取引サマリを取得する
```ruby
response = $client.send(Pokepay::Request::GetPrivateMoneyOrganizationSummaries.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # private_money_id: マネーID
                          from: "2017-02-27T21:41:33.000000+09:00",             # 開始日時(toと同時に指定する必要有)
                          to: "2019-09-19T23:37:41.000000+09:00",               # 終了日時(fromと同時に指定する必要有)
                          page: 1,                                              # ページ番号
                          per_page: 50                                          # 1ページ分の取引数
))
```
`from`と`to`は同時に指定する必要があります。

成功したときは[PaginatedPrivateMoneyOrganizationSummaries](#paginated-private-money-organization-summaries)オブジェクトを返します
### Bulk
<a name="bulk-create-transaction"></a>
#### CSVファイル一括取引
CSVファイルから一括取引をします。
```ruby
response = $client.send(Pokepay::Request::BulkCreateTransaction.new(
                          "b",                                                  # name: 一括取引タスク名
                          "YJ",                                                 # content: 取引する情報のCSV
                          "UFWp4SJDd9Vw0ghvUwHY4GPMgqa4p3NBV6jn",               # request_id: リクエストID
                          description: "EmNinmBAkCQlWqd4VgtaT7nx9nCCSGOYqsqY3PQB7j8S1LcJM99jV6h5DQ4TL9sXbFiut" # 一括取引の説明
))
```

---
`name`  
一括取引タスクの管理用の名前です。

---
`description`  
一括取引タスクの管理用の説明文です。

---
`content`  
一括取引する情報を書いたCSVの文字列です。
1行目はヘッダ行で、2行目以降の各行にカンマ区切りの取引データを含みます。
カラムは以下の7つです。任意のカラムには空文字を指定します。

- `type`: 取引種別
  - 必須。'topup' または 'payment'
- `sender_id`: 送金ユーザーID
  - 必須。UUID
- `receiver_id`: 受取ユーザーID
  - 必須。UUID
- `private_money_id`: マネーID
  - 必須。UUID
- `money_amount`: マネー額
  - 任意。ただし `point_amount` といずれかが必須。0以上の数字
- `point_amount`: ポイント額
  - 任意。ただし `money_amount` といずれかが必須。0以上の数字
- `description`: 取引の説明文
  - 任意。200文字以内。取引履歴に表示される文章
- `bear_account_id`: ポイント負担ウォレットID
  - `point_amount` があるときは必須。UUID
- `point_expires_at`: ポイントの有効期限
  - 任意。指定がないときはマネーに設定された有効期限を適用

---
`request_id`  
重複したリクエストを判断するためのユニークID。ランダムな36字の文字列を生成して渡してください。

---
成功したときは[BulkTransaction](#bulk-transaction)オブジェクトを返します
## Responses


<a name="account-with-user"></a>
## AccountWithUser
* `id (string)`: 
* `name (string)`: 
* `is_suspended (boolean)`: 
* `private_money (PrivateMoney)`: 
* `user (User)`: 

`private_money`は [PrivateMoney](#private-money) オブジェクトを返します。

`user`は [User](#user) オブジェクトを返します。

<a name="account-detail"></a>
## AccountDetail
* `id (string)`: 
* `name (string)`: 
* `is_suspended (boolean)`: 
* `balance (double)`: 
* `money_balance (double)`: 
* `point_balance (double)`: 
* `private_money (PrivateMoney)`: 

`private_money`は [PrivateMoney](#private-money) オブジェクトを返します。

<a name="bill"></a>
## Bill
* `id (string)`: 支払いQRコードのID
* `amount (double)`: 支払い額
* `max_amount (double)`: 支払い額を範囲指定した場合の上限
* `min_amount (double)`: 支払い額を範囲指定した場合の下限
* `description (string)`: 支払いQRコードの説明文(アプリ上で取引の説明文として表示される)
* `account (AccountWithUser)`: 支払いQRコード発行ウォレット
* `is_disabled (boolean)`: 無効化されているかどうか
* `token (string)`: 

`account`は [AccountWithUser](#account-with-user) オブジェクトを返します。

<a name="user"></a>
## User
* `id (string)`: ユーザー (または店舗) ID
* `name (string)`: ユーザー (または店舗) 名
* `is_merchant (boolean)`: 店舗ユーザーかどうか

<a name="transaction"></a>
## Transaction
* `id (string)`: 取引ID
* `type (string)`: 取引種別 (チャージ=topup, 支払い=payment)
* `is_modified (boolean)`: 返金された取引かどうか
* `sender (User)`: 送金者情報
* `sender_account (Account)`: 送金ウォレット情報
* `receiver (User)`: 受取者情報
* `receiver_account (Account)`: 受取ウォレット情報
* `amount (double)`: 決済総額 (マネー額 + ポイント額)
* `money_amount (double)`: 決済マネー額
* `point_amount (double)`: 決済ポイント額
* `done_at (string)`: 取引日時
* `description (string)`: 取引説明文

`receiver`と`sender`は [User](#user) オブジェクトを返します。

`receiver_account`と`sender_account`は [Account](#account) オブジェクトを返します。

<a name="bulk-transaction"></a>
## BulkTransaction
* `request_id (string)`: リクエストID
* `name (string)`: バルクチャージ管理用の名前
* `description (string)`: バルクチャージ管理用の説明文
* `status (string)`: バルクチャージの状態
* `submitted_at (string)`: バルクチャージが登録された日時
* `updated_at (string)`: バルクチャージが更新された日時

<a name="paginated-private-money-organization-summaries"></a>
## PaginatedPrivateMoneyOrganizationSummaries
* `rows (array of PrivateMoneyOrganizationSummaries)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [PrivateMoneyOrganizationSummary](#private-money-organization-summary) オブジェクトの配列を返します。

`pagination`は [Pagination](#pagination) オブジェクトを返します。

<a name="paginated-transaction"></a>
## PaginatedTransaction
* `rows (array of Transactions)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [Transaction](#transaction) オブジェクトの配列を返します。

`pagination`は [Pagination](#pagination) オブジェクトを返します。

<a name="paginated-transfers"></a>
## PaginatedTransfers
* `rows (array of Transfers)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [Transfer](#transfer) オブジェクトの配列を返します。

`pagination`は [Pagination](#pagination) オブジェクトを返します。

<a name="paginated-accounts"></a>
## PaginatedAccounts
* `rows (array of Accounts)`: 
* `count (integer)`: 
* `pagination (Pagination)`: 

`rows`は [Account](#account) オブジェクトの配列を返します。

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
* `type (string)`: マネー種別 (自家型=own, 第三者型=third-party)
* `expiration_type (string)`: 有効期限種別 (チャージ日起算=static, 最終利用日起算=last-update, 最終チャージ日起算=last-topup-update)
* `enable_topup_by_member (boolean)`: 加盟店によるチャージが有効かどうか
* `account_image (string)`: マネーの画像URL

`organization`は [Organization](#organization) オブジェクトを返します。

<a name="account"></a>
## Account
* `id (string)`: ウォレットID
* `name (string)`: ウォレット名
* `is_suspended (boolean)`: ウォレットが凍結されているかどうか
* `private_money (PrivateMoney)`: 設定マネー情報

`private_money`は [PrivateMoney](#private-money) オブジェクトを返します。

<a name="private-money-organization-summary"></a>
## PrivateMoneyOrganizationSummary
* `organization_code (string)`: 
* `topup (OrganizationSummary)`: 
* `payment (OrganizationSummary)`: 

`payment`と`topup`は [OrganizationSummary](#organization-summary) オブジェクトを返します。

<a name="pagination"></a>
## Pagination
* `current (integer)`: 
* `per_page (integer)`: 
* `max_page (integer)`: 
* `has_prev (boolean)`: 
* `has_next (boolean)`: 

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
* `postal_code (string)`: 店舗の郵便番号
* `address (string)`: 店舗の住所
* `tel (string)`: 店舗の電話番号
* `email (string)`: 店舗のメールアドレス
* `external_id (string)`: 店舗の外部ID
