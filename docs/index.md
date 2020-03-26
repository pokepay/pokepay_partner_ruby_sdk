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

### Transaction

<a name="get-transaction"></a>
#### 取引情報を取得する

```ruby
response = client.send(Pokepay::Request::GetTransaction.new(
                         "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" # 取引ID
                         ))

```

成功したときは以下のプロパティを含む `Pokepay::Response::Transaction` オブジェクトをレスポンスとして返します。

- id (String): 取引ID
- type (String): 取引種別 (チャージ=topup, 支払い=payment)
- is_modified (真理値): 返金された取引かどうか
- sender (Pokepay::Response::User): 送金者情報
- receiver (Pokepay::Response::User): 受取者情報
- sender_account (Pokepay::Response::Account): 送金口座情報
- receiver_account (Pokepay::Response::Account): 受取口座情報
- amount (Numeric): 決済総額 (マネー額 + ポイント額)
- money_amount (Numeric): 決済マネー額
- point_amount (Numeric): 決済ポイント額
- done_at (Time): 取引日時
- description (String): 取引説明文

`sender` と `receiver` は `Pokepay::Response::User` のオブジェクトです。 以下にプロパティを示します。

- id (String): ユーザー (または店舗) ID
- name (String): ユーザー (または店舗) 名
- is_merchant (真理値): 店舗ユーザーかどうか

`senderAccount` と `receiverAccount` は `Pokepay::Response::Account` のオブジェクトです。以下にプロパティを示します。

- id (String): 口座ID
- name (String): 口座名
- is_suspended (真理値): 口座が凍結されているかどうか
- private_money (Pokepay::Response::PrivateMoney): 設定マネー情報

`privateMoney` は `Pokepay::Response::PrivateMoney` のオブジェクトです。以下にプロパティを示します。

- id (String): マネーID
- name (String): マネー名
- unit (String): マネー単位 (例: 円)
- is_exclusive (真理値): 会員制のマネーかどうか
- description (String): マネー説明文
- max_balance (Numeric): 口座の上限金額
- transfer_limit (Numeric): マネーの取引上限額
- type (String): マネー種別 (自家型=own, 第三者型=third-party)
- expiration_type (String): 有効期限種別 (チャージ日時起算=static, 最終利用日時起算=last-update)

#### チャージする

```ruby
response = client.send(Pokepay::Request::CreateTopupTransaction.new(
                         "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",   # 店舗ID
                         "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy",   # エンドユーザーのID
                         "zzzzzzzz-zzzz-zzzz-zzzz-zzzzzzzzzzzz",   # 送るマネーのID
                         {
                           "money_amount" => 100,                  # チャージマネー額
                           "point_amount" => 200,                  # チャージするポイント額 (任意)
                           "description" => "チャージテスト"          # 取引履歴に表示する説明文 (任意)
                         }))
```

成功したときは `Pokepay::Response::Transaction` を持つレスポンスオブジェクトを返します。  
プロパティは [取引情報を取得する](#get-transaction) を参照してください。

#### 支払いする

```ruby
response = client.send(Pokepay::Request::CreatePaymentTransaction.new(
                         "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # 店舗ID
                         "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy", # エンドユーザーのID
                         "zzzzzzzz-zzzz-zzzz-zzzz-zzzzzzzzzzzz", # 支払うマネーのID
                         100,                                    # 支払い額
                         {
                           "description"  => "たい焼き(小倉)"      # 取引履歴に表示する説明文 (任意)
                         }))
```

成功したときは `Pokepay::Response::Transaction` オブジェクトをレスポンスとして返します。  
プロパティは [取引情報を取得する](#get-transaction) を参照してください。

#### チャージ用QRコードを読み取ることでチャージする

チャージ用QRコードを解析すると次のようなURLになります(URLは環境によって異なります)。

`https://www-sandbox.pokepay.jp/checks/xxxxxxxx-xxxx-xxxxxxxxx-xxxxxxxxxxxx`

この `xxxxxxxx-xxxx-xxxxxxxxx-xxxxxxxxxxxx` の部分がチャージ用QRコードのIDです。
これを以下のようにエンドユーザIDと共に渡すことでチャージ取引が作られます。

```ruby
response = client.send(Pokepay::Request::CreateTopupTransactionWithCheck.new(
                         "xxxxxxxx-xxxx-xxxxxxxxx-xxxxxxxxxxxx", # チャージ用QRコードのID
                         "yyyyyyyy-yyyy-yyyyyyyyy-yyyyyyyyyyyy"  # エンドユーザーのID
                         ))
```

成功したときは `Pokepay::Response::Transaction` オブジェクトをレスポンスとして返します。  
プロパティは [取引情報を取得する](#get-transaction) を参照してください。

#### 取引履歴を取得する

```ruby
response = client.send(Pokepay::Request::ListTransactions.new(
                         {
                           # ページング
                           "page"     => 1,
                           "per_page" => 50,

                           # フィルタオプション (すべて任意)
                           # 期間指定 (ISO8601形式の文字列)
                           "from" => "2019-01-01T00:00:00+09:00",
                           "to"   => "2019-07-30T18:13:39+09:00",

                           # 検索オプション
                           "customer_id"    => "xxxxxxxxxxxxxxxxx", # エンドユーザーID
                           "customer_name"  => "福沢",               # エンドユーザー名
                           "transaction_id" => "24bba30c......",    # 取引ID
                           "shop_id"        => "456a820b......",    # 店舗ID
                           "terminal_id"    => "d8023185......",    # 端末ID
                           "organization"   => "pocketchange",      # 組織コード
                           "private_money"  => "9ff644fc......",    # マネーID
                           "is_modified"    => "true",              # キャンセルされた取引のみ検索するか
                           # 取引種別 (複数指定可)、チャージ=topup、支払い=payment
                           "types"          => ["topup", "payment"],
                         }))
```

成功したときは `Pokepay::Response::Transaction` を `rows` に含むページングオブジェクトを返します。  
詳細は [ページング](#paging) を参照してください。

#### 返金する

```ruby
response = client.send(Pokepay::Request::RefundTransaction.new(
                         "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # 取引ID
                         {
                           "description" => "返品対応のため"        # 取引履歴に表示する返金事由 (任意)
                         }))
```

成功したときは `Pokepay::Response::Transfer` のオブジェクトを返します。  
以下にプロパティを示します。

- id (string): 送金ID
- sender (Response\User): 送金者情報
- receiver (Response\User): 受取者情報
- senderAccount (Response\Account): 送金口座情報
- receiverAccount (Response\Account): 受取口座情報
- amount (double): 決済総額 (マネー額 + ポイント額)
- moneyAmount (double): 決済マネー額
- pointAmount (double): 決済ポイント額
- doneAt (DateTime): 取引日時
- description (string): 取引説明文

### Customer

#### 新規エンドユーザー口座を追加する

```ruby
response = client.send(Pokepay::Request::CreateCustomerAccount.new(
                         "zzzzzzzz-zzzz-zzzz-zzzz-zzzzzzzzzzzz",    # マネーのID
                         {
                           "user_name" => "ポケペイ太郎",             #  ユーザー名 (任意)
                           "account_name" => "ポケペイ太郎のアカウント" # アカウント名 (任意)
                         }))
```

成功したときは以下のプロパティを持つ `Pokepay::Response::AccountWithUser` のオブジェクトをレスポンスとして返します。

- id (string): 口座ID
- name (string): 口座名
- isSuspended (bool): 口座が凍結されているかどうか
- privateMoney (Response\PrivateMoney): 設定マネー情報
- user (Response\User): ユーザーIDなどを含むユーザー情報

#### エンドユーザーの口座情報を表示する

```ruby
response = client.send(Pokepay::Request::GetAccount.new(
                         "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" # 口座ID
                         ))
```

成功したときは以下のプロパティを持つ `Pokepay::Response::AccountDetail` のオブジェクトをレスポンスとして返します。

- id (string): 口座ID
- name (string): 口座名
- isSuspended (bool): 口座が凍結されているかどうか
- balance (double): 総残高
- moneyBalance (double): 総マネー残高
- pointBalance (double): 総ポイント残高
- privateMoney (Response\PrivateMoney): 設定マネー情報

#### エンドユーザーの残高内訳を表示する

エンドユーザーの残高は有効期限別のリストとして取得できます。

```ruby
response = client.send(Pokepay::Request::ListAccountBalances.new(
                         "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # 口座ID
                         ))
```

成功したときは `Pokepay::Response::AccountBalance` を `rows` に含むページングオブジェクトを返します。  
詳細は [ページング](#paging) を参照してください。

`Pokepay::Response::AccountBalance` のプロパティは以下の通りです。

- expiresAt (DateTime): 失効日時
- moneyAmount (double): マネー額
- pointAmount (double): ポイント額

### Organization

#### 新規加盟店組織を追加する

```ruby
response = client.send(Pokepay::Request::CreateOrganization.new(
                         "ox_supermarket",                   # 新規組織コード
                         "oxスーパー",                         # 新規組織名
                         "pay@xx-issuer-company.jp",         # 発行体担当者メールアドレス
                         "admin+pokepay@ox-supermarket.com", # 新規組織担当者メールアドレス
                         {
                           # 追加データ (すべて任意)
                           "bank_name"                => "XYZ銀行",  # 銀行名
                           "bank_code"                => "999X",    # 銀行金融機関コード
                           "bank_branch_name"         => "ABC支店",  # 銀行支店名
                           "bank_banch_code"          => "99X",     # 銀行支店コード
                           "bank_account_type"        => "saving",  # 銀行口座種別 (普通=saving, 当座=current, その他=other)
                           "bank_account"             => "9999999", # 銀行口座番号
                           "bank_account_holder_name" => "ﾌｸｻﾞﾜﾕｷﾁ", # 口座名義人名
                         }))
```

成功したときには以下のプロパティを持つ `Pokepay::Response::Organization` のオブジェクトをレスポンスとして返します。

- code (string): 組織コード
- name (string): 組織名

### Shop

#### 新規店舗を追加する

```ruby
response = client.send(Pokepay::Request::CreateShop.new(
                         "OXスーパー三田店",             # 店舗名
                         {
                           # 追加データ (すべて任意)
                           "shop_postal_code" => "108-0014",                # 店舗の郵便番号
                           "shop_address"     => "東京都港区芝...",           # 店舗の住所
                           "shop_tel"         => "03-xxxx...",              # 店舗の電話番号
                           "shop_email"       => "mita@ox-supermarket.com", # 店舗のメールアドレス
                           "shop_external_id" => "mita0309",                # 店舗の外部ID
                         }))
```

成功したときは以下のプロパティを持つ `Pokepay::Response::User` のオブジェクトをレスポンスとして返します。

- id (string): 店舗ID
- name (string): 店舗名
- isMerchant (bool): 店舗かどうかのフラグ (この場合は常に真)

### Private Money

#### 決済加盟店の取引サマリを取得する

```ruby
response = client.send(Pokepay::Request::GetPrivateMoneyOrganizationSummaries.new(
                         "zzzzzzzz-zzzz-zzzz-zzzz-zzzzzzzzzzzz", # マネーのID
                         {
                           # フィルタオプション (すべて任意)
                           # 期間指定 (ISO8601形式の文字列、またはDateTimeオブジェクト)
                           # fromとtoを指定する場合は同時に指定する必要あり。
                           # デフォルトではfromは昨日0時、toは当日0時。
                          "from" => "2019-01-01T00:00:00+09:00",
                          "to"   => "2019-07-31T18:13:39+09:00",

                          # ページングオプション
                          "page"     => 1,
                          "per_page" => 50
                         }))
```

成功したときは `Pokepay::Response::PrivateMoneyOrganizationSummary` を `rows` に含むページングオブジェクトを返します。  
以下にプロパティを示します。

- organizationCode (string): 組織コード
- topup (Response::OrganizationSummary): チャージのサマリ情報
- payment (Response::OrganizationSummary): 支払いのサマリ情報

`Pokepay::Response::OrganizationSummary` のプロパティを以下に示します。

- count (integer): 取引数
- moneyAmount (double): 取引マネー総額
- moneyCount (integer): マネー取引数
- pointAmount (double): 取引ポイント総額
- pointCount (integer): ポイント取引数

ページングについての詳細は [ページング](#paging) を参照してください。
