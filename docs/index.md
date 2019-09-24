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
- 設定ファイル(後述)から Pokepay::Client オブジェクトを作る
- リクエストオブジェクトを作り、Pokepay::Client オブジェクトのsendメソッドに対して渡す
- レスポンスオブジェクトを得る

```ruby
require "pokepay_partner_ruby_sdk"
client = Pokepay::Client.new("/path/to/config.ini")
request = Pokepay::Request::SendEcho.new('hello')
response = client.send(request)
```

レスポンスオブジェクト内にステータスコード、JSONをパースしたハッシュマップ、さらにレスポンス内容のオブジェクトが含まれています。

## Settings

設定はINIファイルに記述し、 Pokepay::Client のコンストラクタにファイルパスを指定します。

SDKプロジェクトルートに config.ini.sample というファイルがありますのでそれを元に必要な情報を記述してください。特に以下の情報は通信の安全性のため必要な項目です。これらはパートナー契約時にお渡ししているものです。

- CLIENT_ID: パートナーAPI クライアントID
- CLIENT_SECRET: パートナーAPI クライアント秘密鍵
- SSL_KEY_FILE: SSL秘密鍵ファイルパス
- SSL_CERT_FILE: SSL証明書ファイルパス

この他に接続先のサーバURL情報が必要です。

- API_BASE_URL: パートナーAPI サーバURL

また、この設定ファイルには認証に必要な情報が含まれるため、ファイルの管理・取り扱いに十分注意してください。

設定ファイル記述例(config.ini.sample)

```
CLIENT_ID        = xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
CLIENT_SECRET    = yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
API_BASE_URL     = https://partnerapi-sandbox.pokepay.jp
SSL_KEY_FILE     = /path/to/key.pem
SSL_CERT_FILE    = /path/to/cert.pem
```

## Overview

### APIリクエスト

Partner APIへの通信はリクエストオブジェクトを作り、Pokepay::Client.send メソッドに渡すことで行われます。リクエストクラスは名前空間 Pokepay::Request 以下に定義されています。

たとえば Pokepay::Request::SendEcho 送信した内容をそのまま返す処理です。

```ruby
request = Pokepay::Request::SendEcho.new('hello')

response = client.send(request)
# => #<Pokepay::Response::Response 200 OK readbody=>
```

通信の結果として、レスポンスオブジェクトが得られます。これはステータスコードとレスポンスボディ、各レスポンスクラスのオブジェクトをインスタンス変数に持つオブジェクトです。

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

エラーの場合は Net::HTTPBadRequest などのエラーレスポンスオブジェクトが返ります。エラーレスポンスもステータスコードとレスポンスボディを持ちます。

```ruby
request = Pokepay::Request::SendEcho.new(-1)

response = client.send(request)
# => #<Net::HTTPBadRequest 400 Bad Request readbody=true>

response.code
# => 400

response.body
# => {"type"=>"invalid_parameters", "message"=>"Invalid parameters", "errors"=>{"invalid"=>["message"]}}
```

## API Operations

### 取引一覧を取得する

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
                           "customer_name"  => "福沢",           # エンドユーザー名
                           "transaction_id" => "24bba30c......", # 取引ID
                           "shop_id"        => "456a820b......", # 店舗ID
                           "terminal_id"    => "d8023185......", # 端末ID
                           "organization"   => "pocketchange",   # 組織コード
                           "private_money"  => "9ff644fc......", # マネーID
                           "is_modified"    => "true",           # キャンセルされた取引のみ検索するか
                           # 取引種別 (複数指定可)、チャージ=topup、支払い=payment
                           "types"          => ["topup", "payment"],
                         }))
```

成功したときは Pokepay::Response::Transaction を rows に含むページングオブジェクトを返します。
取引一覧のような大量のレスポンスが返るエンドポイントでは、一度に取得する量を制限するためにページングされています。

#### 取引情報

取引クラスは Pokepay::Response::Transaction で定義されています。

取引オブジェクトのプロパティは以下のようになっています。

- id (String): 取引ID
- type (String): 取引種別 (チャージ=topup, 支払い=payment)
- is_modified (真理値): 返金された取引かどうか
- sender (Response\User): 送金者情報
- receiver (Response\User): 受取者情報
- sender_account (Response\Account): 送金口座情報
- receiver_account (Response\Account): 受取口座情報
- amount (Numeric): 決済総額 (マネー額 + ポイント額)
- money_amount (Numeric): 決済マネー額
- point_amount (Numeric): 決済ポイント額
- done_at (Time): 取引日時
- description (String): 取引説明文

`sender` と `receiver` には `Pokepay::Response::User` のオブジェクトです。 以下にプロパティを示します。

- id (String): ユーザー (または店舗) ID
- name (String): ユーザー (または店舗) 名
- is_merchant (真理値): 店舗ユーザーかどうか

`senderAccount` と `receiverAccount` は `Pokepay::Response::Account` のオブジェクトです。以下にプロパティを示します。

- id (String): 口座ID
- name (String): 口座名
- is_suspended (真理値): 口座が凍結されているかどうか
- private_money (Response\PrivateMoney): 設定マネー情報

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

#### ページング

ページングクラスは Pokepay::Response::Pagination で定義されています。

ページングオブジェクトのプロパティは以下のようになっています。

- rows : 列挙するレスポンスクラスのオブジェクトの配列
- count : 全体の要素数
- pagination : 以下のインスタンス変数を持つオブジェクト
  - current : 現在のページ位置(1からスタート)
  - per_page : 1ページ当たりの要素数
  - max_page : 最後のページ番号
  - has_prev : 前ページを持つかどうかの真理値
  - has_next : 次ページを持つかどうかの真理値

### チャージする

```ruby
shop_id          = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" # 店舗ID
customer_id      = "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy" # エンドユーザーのID
private_money_id = "zzzzzzzz-zzzz-zzzz-zzzz-zzzzzzzzzzzz" # 送るマネーのID
money_amount     = 1000                                   # チャージマネー額
point_amount     = 0                                      # チャージするポイント額
description      = "初夏のチャージキャンペーン"           # 取引履歴に表示する説明文

response = $client.send(Pokepay::Request::CreateTransaction.new(
                          shop_id, customer_id, private_money_id,
                          money_amount, point_amount, description))
```

成功したときは Pokepay::Response::Transaction を持つレスポンスオブジェクトを返します。
