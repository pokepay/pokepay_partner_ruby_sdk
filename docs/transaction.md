# Transaction

<a name="get-cpm-token"></a>
## GetCpmToken: CPMトークンの状態取得
CPMトークンの現在の状態を取得します。CPMトークンの有効期限やCPM取引の状態を返します。

```RUBY
response = $client.send(Pokepay::Request::GetCpmToken.new(
                          "zroFJfg0zCih9qHu842U5S"                              # cpm_token: CPMトークン
))
```



### Parameters
**`cpm_token`** 
  

CPM取引時にエンドユーザーが店舗に提示するバーコードを解析して得られる22桁の文字列です。

```json
{
  "type": "string",
  "minLength": 22,
  "maxLength": 22
}
```



成功したときは
[CpmToken](./responses.md#cpm-token)
を返します


---


<a name="list-transactions"></a>
## ListTransactions: 【廃止】取引履歴を取得する
取引一覧を返します。

```RUBY
response = $client.send(Pokepay::Request::ListTransactions.new(
                          from: "2021-06-05T21:00:30.000000Z",                  # 開始日時
                          to: "2020-10-02T07:49:29.000000Z",                    # 終了日時
                          page: 1,                                              # ページ番号
                          per_page: 50,                                         # 1ページ分の取引数
                          shop_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",      # 店舗ID
                          customer_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",  # エンドユーザーID
                          customer_name: "太郎",                                  # エンドユーザー名
                          terminal_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",  # 端末ID
                          transaction_id: "NqipKVsII",                          # 取引ID
                          organization_code: "pocketchange",                    # 組織コード
                          private_money_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # マネーID
                          is_modified: false,                                   # キャンセルフラグ
                          types: ["topup", "payment"],                          # 取引種別 (複数指定可)、チャージ=topup、支払い=payment
                          description: "店頭QRコードによる支払い"                          # 取引説明文
))
```



### Parameters
**`from`** 
  

抽出期間の開始日時です。

フィルターとして使われ、開始日時以降に発生した取引のみ一覧に表示されます。

```json
{
  "type": "string",
  "format": "date-time"
}
```

**`to`** 
  

抽出期間の終了日時です。

フィルターとして使われ、終了日時以前に発生した取引のみ一覧に表示されます。

```json
{
  "type": "string",
  "format": "date-time"
}
```

**`page`** 
  

取得したいページ番号です。

```json
{
  "type": "integer",
  "minimum": 1
}
```

**`per_page`** 
  

1ページ分の取引数です。

```json
{
  "type": "integer",
  "minimum": 1
}
```

**`shop_id`** 
  

店舗IDです。

フィルターとして使われ、指定された店舗での取引のみ一覧に表示されます。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`customer_id`** 
  

エンドユーザーIDです。

フィルターとして使われ、指定されたエンドユーザーでの取引のみ一覧に表示されます。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`customer_name`** 
  

エンドユーザー名です。

フィルターとして使われ、入力された名前に部分一致するエンドユーザーでの取引のみ一覧に表示されます。

```json
{
  "type": "string",
  "maxLength": 256
}
```

**`terminal_id`** 
  

端末IDです。

フィルターとして使われ、指定された端末での取引のみ一覧に表示されます。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`transaction_id`** 
  

取引IDです。

フィルターとして使われ、指定された取引IDに部分一致(前方一致)する取引のみが一覧に表示されます。

```json
{
  "type": "string"
}
```

**`organization_code`** 
  

組織コードです。

フィルターとして使われ、指定された組織での取引のみ一覧に表示されます。

```json
{
  "type": "string",
  "maxLength": 32,
  "pattern": "^[a-zA-Z0-9-]*$"
}
```

**`private_money_id`** 
  

マネーIDです。

フィルターとして使われ、指定したマネーでの取引のみ一覧に表示されます。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`is_modified`** 
  

キャンセルフラグです。

これにtrueを指定するとキャンセルされた取引のみ一覧に表示されます。
デフォルト値はfalseで、キャンセルの有無にかかわらず一覧に表示されます。

```json
{
  "type": "boolean"
}
```

**`types`** 
  

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

5. cashback
   退会時返金取引

6. expire
   退会時失効取引

```json
{
  "type": "array",
  "items": {
    "type": "string",
    "enum": [
      "topup",
      "payment",
      "exchange_outflow",
      "exchange_inflow",
      "cashback",
      "expire"
    ]
  }
}
```

**`description`** 
  

取引を指定の取引説明文でフィルターします。

取引説明文が完全一致する取引のみ抽出されます。取引説明文は最大200文字で記録されています。

```json
{
  "type": "string",
  "maxLength": 200
}
```



成功したときは
[PaginatedTransaction](./responses.md#paginated-transaction)
を返します


---


<a name="create-transaction"></a>
## CreateTransaction: 【廃止】チャージする
チャージ取引を作成します。このAPIは廃止予定です。以降は `CreateTopupTransaction` を使用してください。

```RUBY
response = $client.send(Pokepay::Request::CreateTransaction.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                          money_amount: 362,
                          point_amount: 3542,
                          point_expires_at: "2024-03-01T17:10:50.000000Z",      # ポイント有効期限
                          description: "x3ZiMVPZEq0xgguEtAXJ6WozfUGo1oVR"
))
```



### Parameters
**`shop_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```

**`customer_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```

**`private_money_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```

**`money_amount`** 
  


```json
{
  "type": "integer",
  "format": "decimal",
  "minimum": 0
}
```

**`point_amount`** 
  


```json
{
  "type": "integer",
  "format": "decimal",
  "minimum": 0
}
```

**`point_expires_at`** 
  

ポイントをチャージした場合の、付与されるポイントの有効期限です。
省略した場合はマネーに設定された有効期限と同じものがポイントの有効期限となります。

```json
{
  "type": "string",
  "format": "date-time"
}
```

**`description`** 
  


```json
{
  "type": "string",
  "maxLength": 200
}
```



成功したときは
[TransactionDetail](./responses.md#transaction-detail)
を返します


---


<a name="list-transactions-v2"></a>
## ListTransactionsV2: 取引履歴を取得する
取引一覧を返します。

```RUBY
response = $client.send(Pokepay::Request::ListTransactionsV2.new(
                          private_money_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # マネーID
                          organization_code: "pocketchange",                    # 組織コード
                          shop_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",      # 店舗ID
                          terminal_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",  # 端末ID
                          customer_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",  # エンドユーザーID
                          customer_name: "太郎",                                  # エンドユーザー名
                          description: "店頭QRコードによる支払い",                         # 取引説明文
                          transaction_id: "1P",                                 # 取引ID
                          is_modified: true,                                    # キャンセルフラグ
                          types: ["topup", "payment"],                          # 取引種別 (複数指定可)、チャージ=topup、支払い=payment
                          from: "2024-02-04T04:47:18.000000Z",                  # 開始日時
                          to: "2020-03-06T03:10:42.000000Z",                    # 終了日時
                          next_page_cursor_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # 次ページへ遷移する際に起点となるtransactionのID
                          prev_page_cursor_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # 前ページへ遷移する際に起点となるtransactionのID
                          per_page: 50                                          # 1ページ分の取引数
))
```



### Parameters
**`private_money_id`** 
  

マネーIDです。

指定したマネーでの取引が一覧に表示されます。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`organization_code`** 
  

組織コードです。

フィルターとして使われ、指定された組織の店舗での取引のみ一覧に表示されます。

```json
{
  "type": "string",
  "maxLength": 32,
  "pattern": "^[a-zA-Z0-9-]*$"
}
```

**`shop_id`** 
  

店舗IDです。

フィルターとして使われ、指定された店舗での取引のみ一覧に表示されます。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`terminal_id`** 
  

端末IDです。

フィルターとして使われ、指定された端末での取引のみ一覧に表示されます。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`customer_id`** 
  

エンドユーザーIDです。

フィルターとして使われ、指定されたエンドユーザーの取引のみ一覧に表示されます。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`customer_name`** 
  

エンドユーザー名です。

フィルターとして使われ、入力された名前に部分一致するエンドユーザーでの取引のみ一覧に表示されます。

```json
{
  "type": "string",
  "maxLength": 256
}
```

**`description`** 
  

取引を指定の取引説明文でフィルターします。

取引説明文が完全一致する取引のみ抽出されます。取引説明文は最大200文字で記録されています。

```json
{
  "type": "string",
  "maxLength": 200
}
```

**`transaction_id`** 
  

取引IDです。

フィルターとして使われ、指定された取引IDに部分一致(前方一致)する取引のみが一覧に表示されます。

```json
{
  "type": "string"
}
```

**`is_modified`** 
  

キャンセルフラグです。

これにtrueを指定するとキャンセルされた取引のみ一覧に表示されます。
デフォルト値はfalseで、キャンセルの有無にかかわらず一覧に表示されます。

```json
{
  "type": "boolean"
}
```

**`types`** 
  

取引の種類でフィルターします。

以下の種類を指定できます。

1. topup
   店舗からエンドユーザーへの送金取引(チャージ)

2. payment
   エンドユーザーから店舗への送金取引(支払い)

3. exchange-outflow
   他マネーへの流出
   private_money_idが指定されたとき、そのマネーから見て流出方向の交換取引が抽出されます。
   private_money_idを省略した場合は表示されません。

4. exchange-inflow
   他マネーからの流入
   private_money_idが指定されたとき、そのマネーから見て流入方向の交換取引が抽出されます。
   private_money_idを省略した場合は表示されません。

5. cashback
   退会時返金取引

6. expire
   退会時失効取引

```json
{
  "type": "array",
  "items": {
    "type": "string",
    "enum": [
      "topup",
      "payment",
      "exchange_outflow",
      "exchange_inflow",
      "cashback",
      "expire"
    ]
  }
}
```

**`from`** 
  

抽出期間の開始日時です。

フィルターとして使われ、開始日時以降に発生した取引のみ一覧に表示されます。

```json
{
  "type": "string",
  "format": "date-time"
}
```

**`to`** 
  

抽出期間の終了日時です。

フィルターとして使われ、終了日時以前に発生した取引のみ一覧に表示されます。

```json
{
  "type": "string",
  "format": "date-time"
}
```

**`next_page_cursor_id`** 
  

次ページへ遷移する際に起点となるtransactionのID(前ページの末尾要素のID)です。
本APIのレスポンスにもnext_page_cursor_idが含まれており、これがnull値の場合は最後のページであることを意味します。
UUIDである場合は次のページが存在することを意味し、このnext_page_cursor_idをリクエストパラメータに含めることで次ページに遷移します。

next_page_cursor_idのtransaction自体は次のページには含まれません。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`prev_page_cursor_id`** 
  

前ページへ遷移する際に起点となるtransactionのID(次ページの先頭要素のID)です。

本APIのレスポンスにもprev_page_cursor_idが含まれており、これがnull値の場合は先頭のページであることを意味します。
UUIDである場合は前のページが存在することを意味し、このprev_page_cursor_idをリクエストパラメータに含めることで前ページに遷移します。

prev_page_cursor_idのtransaction自体は前のページには含まれません。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`per_page`** 
  

1ページ分の取引数です。

デフォルト値は50です。

```json
{
  "type": "integer",
  "minimum": 1,
  "maximum": 1000
}
```



成功したときは
[PaginatedTransactionV2](./responses.md#paginated-transaction-v2)
を返します


---


<a name="create-topup-transaction"></a>
## CreateTopupTransaction: チャージする
チャージ取引を作成します。

```RUBY
response = $client.send(Pokepay::Request::CreateTopupTransaction.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # shop_id: 店舗ID
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # customer_id: エンドユーザーのID
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # private_money_id: マネーID
                          bear_point_shop_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # ポイント支払時の負担店舗ID
                          money_amount: 4236,                                   # マネー額
                          point_amount: 5322,                                   # ポイント額
                          point_expires_at: "2021-02-02T23:32:54.000000Z",      # ポイント有効期限
                          description: "初夏のチャージキャンペーン",                         # 取引履歴に表示する説明文
                          metadata: "{\"key\":\"value\"}",                      # 取引メタデータ
                          request_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"    # リクエストID
))
```



### Parameters
**`shop_id`** 
  

店舗IDです。

送金元の店舗を指定します。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`customer_id`** 
  

エンドユーザーIDです。

送金先のエンドユーザーを指定します。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`private_money_id`** 
  

マネーIDです。

マネーを指定します。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`bear_point_shop_id`** 
  

ポイント支払時の負担店舗IDです。

ポイント支払い時に実際お金を負担する店舗を指定します。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`money_amount`** 
  

マネー額です。

送金するマネー額を指定します。
デフォルト値は0で、money_amountとpoint_amountの両方が0のときにはinvalid_parameter_both_point_and_money_are_zero(エラーコード400)が返ります。

```json
{
  "type": "integer",
  "minimum": 0
}
```

**`point_amount`** 
  

ポイント額です。

送金するポイント額を指定します。
デフォルト値は0で、money_amountとpoint_amountの両方が0のときにはinvalid_parameter_both_point_and_money_are_zero(エラーコード400)が返ります。

```json
{
  "type": "integer",
  "minimum": 0
}
```

**`point_expires_at`** 
  

ポイントをチャージした場合の、付与されるポイントの有効期限です。
省略した場合はマネーに設定された有効期限と同じものがポイントの有効期限となります。

```json
{
  "type": "string",
  "format": "date-time"
}
```

**`description`** 
  

取引説明文です。

任意入力で、取引履歴に表示される説明文です。

```json
{
  "type": "string",
  "maxLength": 200
}
```

**`metadata`** 
  

取引作成時に指定されるメタデータです。

任意入力で、全てのkeyとvalueが文字列であるようなフラットな構造のJSON文字列で指定します。

```json
{
  "type": "string",
  "format": "json"
}
```

**`request_id`** 
  

取引作成APIの羃等性を担保するためのリクエスト固有のIDです。

取引作成APIで結果が受け取れなかったなどの理由で再試行する際に、二重に取引が作られてしまうことを防ぐために、クライアント側から指定されます。指定は任意で、UUID V4フォーマットでランダム生成した文字列です。リクエストIDは一定期間で削除されます。

リクエストIDを指定したとき、まだそのリクエストIDに対する取引がない場合、新規に取引が作られレスポンスとして返されます。もしそのリクエストIDに対する取引が既にある場合、既存の取引がレスポンスとして返されます。

```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[TransactionDetail](./responses.md#transaction-detail)
を返します


---


<a name="create-payment-transaction"></a>
## CreatePaymentTransaction: 支払いする
支払取引を作成します。
支払い時には、エンドユーザーの残高のうち、ポイント残高から優先的に消費されます。


```RUBY
response = $client.send(Pokepay::Request::CreatePaymentTransaction.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # shop_id: 店舗ID
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # customer_id: エンドユーザーID
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # private_money_id: マネーID
                          8608,                                                 # amount: 支払い額
                          description: "たい焼き(小倉)",                              # 取引履歴に表示する説明文
                          metadata: "{\"key\":\"value\"}",                      # 取引メタデータ
                          products: [{"jan_code":"abc",
 "name":"name1",
 "unit_price":100,
 "price": 100,
 "is_discounted": false,
 "other":"{}"}],                                                                # 商品情報データ
                          request_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"    # リクエストID
))
```



### Parameters
**`shop_id`** 
  

店舗IDです。

送金先の店舗を指定します。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`customer_id`** 
  

エンドユーザーIDです。

送金元のエンドユーザーを指定します。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`private_money_id`** 
  

マネーIDです。

マネーを指定します。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`amount`** 
  

マネー額です。

送金するマネー額を指定します。

```json
{
  "type": "integer",
  "minimum": 0
}
```

**`description`** 
  

取引説明文です。

任意入力で、取引履歴に表示される説明文です。

```json
{
  "type": "string",
  "maxLength": 200
}
```

**`metadata`** 
  

取引作成時に指定されるメタデータです。

任意入力で、全てのkeyとvalueが文字列であるようなフラットな構造のJSON文字列で指定します。

```json
{
  "type": "string",
  "format": "json"
}
```

**`products`** 
  

一つの取引に含まれる商品情報データです。
以下の内容からなるJSONオブジェクトの配列で指定します。

- `jan_code`: JANコード。64字以下の文字列
- `name`: 商品名。256字以下の文字列
- `unit_price`: 商品単価。0以上の数値
- `price`: 全体の金額(例: 商品単価 × 個数)。0以上の数値
- `is_discounted`: 賞味期限が近いなどの理由で商品が値引きされているかどうかのフラグ。boolean
- `other`: その他商品に関する情報。JSONオブジェクトで指定します。

```json
{
  "type": "array",
  "items": {
    "type": "object"
  }
}
```

**`request_id`** 
  

取引作成APIの羃等性を担保するためのリクエスト固有のIDです。

取引作成APIで結果が受け取れなかったなどの理由で再試行する際に、二重に取引が作られてしまうことを防ぐために、クライアント側から指定されます。指定は任意で、UUID V4フォーマットでランダム生成した文字列です。リクエストIDは一定期間で削除されます。

リクエストIDを指定したとき、まだそのリクエストIDに対する取引がない場合、新規に取引が作られレスポンスとして返されます。もしそのリクエストIDに対する取引が既にある場合、既存の取引がレスポンスとして返されます。

```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[TransactionDetail](./responses.md#transaction-detail)
を返します


---


<a name="create-cpm-transaction"></a>
## CreateCpmTransaction: CPMトークンによる取引作成
CPMトークンにより取引を作成します。
CPMトークンに設定されたスコープの取引を作ることができます。


```RUBY
response = $client.send(Pokepay::Request::CreateCpmTransaction.new(
                          "5SjzUvS2Jlq6P89tC2Mi1P",                             # cpm_token: CPMトークン
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # shop_id: 店舗ID
                          7208.0,                                               # amount: 取引金額
                          description: "たい焼き(小倉)",                              # 取引説明文
                          metadata: "{\"key\":\"value\"}",                      # 店舗側メタデータ
                          products: [{"jan_code":"abc",
 "name":"name1",
 "unit_price":100,
 "price": 100,
 "is_discounted": false,
 "other":"{}"}, {"jan_code":"abc",
 "name":"name1",
 "unit_price":100,
 "price": 100,
 "is_discounted": false,
 "other":"{}"}, {"jan_code":"abc",
 "name":"name1",
 "unit_price":100,
 "price": 100,
 "is_discounted": false,
 "other":"{}"}],                                                                # 商品情報データ
                          request_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"    # リクエストID
))
```



### Parameters
**`cpm_token`** 
  

エンドユーザーによって作られ、アプリなどに表示され、店舗に対して提示される22桁の文字列です。

エンドユーザーによって許可された取引のスコープを持っています。

```json
{
  "type": "string",
  "minLength": 22,
  "maxLength": 22
}
```

**`shop_id`** 
  

店舗IDです。

支払いやチャージを行う店舗を指定します。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`amount`** 
  

取引金額を指定します。

正の値を与えるとチャージになり、負の値を与えると支払いとなります。

```json
{
  "type": "number"
}
```

**`description`** 
  

取引説明文です。

エンドユーザーアプリの取引履歴などに表示されます。

```json
{
  "type": "string",
  "maxLength": 200
}
```

**`metadata`** 
  

取引作成時に店舗側から指定されるメタデータです。

任意入力で、全てのkeyとvalueが文字列であるようなフラットな構造のJSON文字列で指定します。

```json
{
  "type": "string",
  "format": "json"
}
```

**`products`** 
  

一つの取引に含まれる商品情報データです。
以下の内容からなるJSONオブジェクトの配列で指定します。

- `jan_code`: JANコード。64字以下の文字列
- `name`: 商品名。256字以下の文字列
- `unit_price`: 商品単価。0以上の数値
- `price`: 全体の金額(例: 商品単価 × 個数)。0以上の数値
- `is_discounted`: 賞味期限が近いなどの理由で商品が値引きされているかどうかのフラグ。boolean
- `other`: その他商品に関する情報。JSONオブジェクトで指定します。

```json
{
  "type": "array",
  "items": {
    "type": "object"
  }
}
```

**`request_id`** 
  

取引作成APIの羃等性を担保するためのリクエスト固有のIDです。

取引作成APIで結果が受け取れなかったなどの理由で再試行する際に、二重に取引が作られてしまうことを防ぐために、クライアント側から指定されます。指定は任意で、UUID V4フォーマットでランダム生成した文字列です。リクエストIDは一定期間で削除されます。

リクエストIDを指定したとき、まだそのリクエストIDに対する取引がない場合、新規に取引が作られレスポンスとして返されます。もしそのリクエストIDに対する取引が既にある場合、既存の取引がレスポンスとして返されます。

```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[TransactionDetail](./responses.md#transaction-detail)
を返します


---


<a name="create-transfer-transaction"></a>
## CreateTransferTransaction: 個人間送金
エンドユーザー間での送金取引(個人間送金)を作成します。
個人間送金で送れるのはマネーのみで、ポイントを送ることはできません。送金元のマネー残高のうち、有効期限が最も遠いものから順に送金されます。


```RUBY
response = $client.send(Pokepay::Request::CreateTransferTransaction.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # sender_id: 送金元ユーザーID
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # receiver_id: 受取ユーザーID
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # private_money_id: マネーID
                          686.0,                                                # amount: 送金額
                          metadata: "{\"key\":\"value\"}",                      # 取引メタデータ
                          description: "たい焼き(小倉)",                              # 取引履歴に表示する説明文
                          request_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"    # リクエストID
))
```



### Parameters
**`sender_id`** 
  

エンドユーザーIDです。

送金元のエンドユーザー(送り主)を指定します。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`receiver_id`** 
  

エンドユーザーIDです。

送金先のエンドユーザー(受け取り人)を指定します。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`private_money_id`** 
  

マネーIDです。

マネーを指定します。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`amount`** 
  

マネー額です。

送金するマネー額を指定します。

```json
{
  "type": "number",
  "minimum": 0
}
```

**`metadata`** 
  

取引作成時に指定されるメタデータです。

任意入力で、全てのkeyとvalueが文字列であるようなフラットな構造のJSON文字列で指定します。

```json
{
  "type": "string",
  "format": "json"
}
```

**`description`** 
  

取引説明文です。

任意入力で、取引履歴に表示される説明文です。

```json
{
  "type": "string",
  "maxLength": 200
}
```

**`request_id`** 
  

取引作成APIの羃等性を担保するためのリクエスト固有のIDです。

取引作成APIで結果が受け取れなかったなどの理由で再試行する際に、二重に取引が作られてしまうことを防ぐために、クライアント側から指定されます。指定は任意で、UUID V4フォーマットでランダム生成した文字列です。リクエストIDは一定期間で削除されます。

リクエストIDを指定したとき、まだそのリクエストIDに対する取引がない場合、新規に取引が作られレスポンスとして返されます。もしそのリクエストIDに対する取引が既にある場合、既存の取引がレスポンスとして返されます。

```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[TransactionDetail](./responses.md#transaction-detail)
を返します


---


<a name="create-exchange-transaction"></a>
## CreateExchangeTransaction

```RUBY
response = $client.send(Pokepay::Request::CreateExchangeTransaction.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                          5541,
                          description: "Re6ex8zQnoMXPxIs0d6X24reGHeQvAPqGMsA1rgfPu4olvC1KDDE1G2mGU9YeDH5Tysjz5v4HW6eqkSknjWS4aW80Xp5YCo9TXEMx6Q3N4lydCpBzThmgOIjIatpE7508LaYMNkxpSQqkfWLu8WbqqwjfwNPVeBo88egFulBO0tWJ9",
                          request_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"    # リクエストID
))
```



### Parameters
**`user_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```

**`sender_private_money_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```

**`receiver_private_money_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```

**`amount`** 
  


```json
{
  "type": "integer",
  "minimum": 1
}
```

**`description`** 
  


```json
{
  "type": "string",
  "maxLength": 200
}
```

**`request_id`** 
  

取引作成APIの羃等性を担保するためのリクエスト固有のIDです。

取引作成APIで結果が受け取れなかったなどの理由で再試行する際に、二重に取引が作られてしまうことを防ぐために、クライアント側から指定されます。指定は任意で、UUID V4フォーマットでランダム生成した文字列です。リクエストIDは一定期間で削除されます。

リクエストIDを指定したとき、まだそのリクエストIDに対する取引がない場合、新規に取引が作られレスポンスとして返されます。もしそのリクエストIDに対する取引が既にある場合、既存の取引がレスポンスとして返されます。

```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[TransactionDetail](./responses.md#transaction-detail)
を返します


---


<a name="get-transaction"></a>
## GetTransaction: 取引情報を取得する
取引を取得します。

```RUBY
response = $client.send(Pokepay::Request::GetTransaction.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"                # transaction_id: 取引ID
))
```



### Parameters
**`transaction_id`** 
  

取引IDです。

フィルターとして使われ、指定した取引IDの取引を取得します。

```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[TransactionDetail](./responses.md#transaction-detail)
を返します


---


<a name="refund-transaction"></a>
## RefundTransaction: 取引をキャンセルする
取引IDを指定して取引をキャンセルします。

発行体の管理者は自組織の直営店、または発行しているマネーの決済加盟店組織での取引をキャンセルできます。
キャンセル対象の取引に付随するポイント還元キャンペーンやクーポン適用も取り消されます。

チャージ取引のキャンセル時に返金すべき残高が足りないときは `account_balance_not_enough (422)` エラーが返ります。
取引をキャンセルできるのは1回きりです。既にキャンセルされた取引を重ねてキャンセルしようとすると `transaction_already_refunded (422)` エラーが返ります。

```RUBY
response = $client.send(Pokepay::Request::RefundTransaction.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # transaction_id: 取引ID
                          description: "返品対応のため",                               # 取引履歴に表示する返金事由
                          returning_point_expires_at: "2023-04-11T16:40:53.000000Z" # 返却ポイントの有効期限
))
```



### Parameters
**`transaction_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```

**`description`** 
  


```json
{
  "type": "string",
  "maxLength": 200
}
```

**`returning_point_expires_at`** 
  

ポイント支払いを含む支払い取引をキャンセルする際にユーザへ返却されるポイントの有効期限です。デフォルトでは未指定です。

```json
{
  "type": "string",
  "format": "date-time"
}
```



成功したときは
[TransactionDetail](./responses.md#transaction-detail)
を返します


---


<a name="get-transaction-by-request-id"></a>
## GetTransactionByRequestId: リクエストIDから取引情報を取得する
取引を取得します。

```RUBY
response = $client.send(Pokepay::Request::GetTransactionByRequestId.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"                # request_id: リクエストID
))
```



### Parameters
**`request_id`** 
  

取引作成時にクライアントが生成し指定するリクエストIDです。

リクエストIDに対応する取引が存在すればその取引を返し、無ければNotFound(404)を返します。

```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[TransactionDetail](./responses.md#transaction-detail)
を返します


---


<a name="get-bulk-transaction"></a>
## GetBulkTransaction: バルク取引ジョブの実行状況を取得する

```RUBY
response = $client.send(Pokepay::Request::GetBulkTransaction.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"                # bulk_transaction_id: バルク取引ジョブID
))
```



### Parameters
**`bulk_transaction_id`** 
  

バルク取引ジョブIDです。
バルク取引ジョブ登録時にレスポンスに含まれます。

```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[BulkTransaction](./responses.md#bulk-transaction)
を返します


---


<a name="list-bulk-transaction-jobs"></a>
## ListBulkTransactionJobs: バルク取引ジョブの詳細情報一覧を取得する

```RUBY
response = $client.send(Pokepay::Request::ListBulkTransactionJobs.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # bulk_transaction_id: バルク取引ジョブID
                          page: 1,                                              # ページ番号
                          per_page: 50                                          # 1ページ分の取得数
))
```



### Parameters
**`bulk_transaction_id`** 
  

バルク取引ジョブIDです。
バルク取引ジョブ登録時にレスポンスに含まれます。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`page`** 
  

取得したいページ番号です。

```json
{
  "type": "integer",
  "minimum": 1
}
```

**`per_page`** 
  

1ページ分の取得数です。デフォルトでは 50 になっています。

```json
{
  "type": "integer",
  "minimum": 1
}
```



成功したときは
[PaginatedBulkTransactionJob](./responses.md#paginated-bulk-transaction-job)
を返します


---


<a name="request-user-stats"></a>
## RequestUserStats: 指定期間内の顧客が行った取引の統計情報をCSVでダウンロードする
期間を指定して、期間内に発行マネーの全顧客が行った取引の総額・回数などをCSVでダウンロードする機能です。
CSVの作成は非同期で行われるため完了まで少しの間待つ必要がありますが、完了時にダウンロードできるURLをレスポンスとして返します。
このURLの有効期限はリクエスト日時から7日間です。

ダウンロードできるCSVのデータは以下のものです。

* organization_code: 取引を行った組織コード
* private_money_id: 取引されたマネーのID
* private_money_name: 取引されたマネーの名前
* user_id: 決済したユーザーID
* user_external_id: 決済したユーザーの外部ID
* payment_money_amount: 指定期間内に決済に使ったマネーの総額
* payment_point_amount: 指定期間内に決済に使ったポイントの総額
* payment_transaction_count: 指定期間内に決済した回数。キャンセルされた取引は含まない

また、指定期間より前の決済を時間をおいてキャンセルした場合などには payment_money_amount, payment_point_amount, payment_transaction_count が負の値になることもあることに留意してください。

```RUBY
response = $client.send(Pokepay::Request::RequestUserStats.new(
                          "2022-05-20T17:56:49.000000+09:00",                   # from: 集計期間の開始時刻
                          "2023-12-10T01:16:11.000000+09:00"                    # to: 集計期間の終了時刻
))
```



### Parameters
**`from`** 
  

集計する期間の開始時刻をISO8601形式で指定します。
時刻は現在時刻、及び `to` で指定する時刻以前である必要があります。

```json
{
  "type": "string",
  "format": "date-time"
}
```

**`to`** 
  

集計する期間の終了時刻をISO8601形式で指定します。
時刻は現在時刻、及び `from` で指定する時刻の間である必要があります。

```json
{
  "type": "string",
  "format": "date-time"
}
```



成功したときは
[UserStatsOperation](./responses.md#user-stats-operation)
を返します


---



