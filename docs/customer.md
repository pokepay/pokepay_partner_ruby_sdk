# Customer
エンドユーザー（顧客）のウォレット情報を管理するためのAPIです。
エンドユーザーのウォレット（アカウント）の作成・更新・取得を行います。
ウォレットにはマネー残高（有償バリュー）とポイント残高（無償バリュー）があり、
有効期限別に金額が管理されています。
また、外部システム連携用のexternal_idやメタデータを設定することも可能です。


<a name="delete-account"></a>
## DeleteAccount: ウォレットを退会する
ウォレットを退会します。一度ウォレットを退会した後は、そのウォレットを再び利用可能な状態に戻すことは出来ません。

```RUBY
response = $client.send(Pokepay::Request::DeleteAccount.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # account_id: ウォレットID
                          cashback: false                                       # 返金有無
))
```



### Parameters
#### `account_id`
ウォレットIDです。

指定したウォレットIDのウォレットを退会します。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `cashback`
退会時の返金有無です。エンドユーザに返金を行う場合、真を指定して下さい。現在のマネー残高を全て現金で返金したものとして記録されます。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "boolean"
}
```

</details>



成功したときは
[AccountDeleted](./responses.md#account-deleted)
を返します



---


<a name="get-account"></a>
## GetAccount: ウォレット情報を表示する
ウォレットを取得します。

```RUBY
response = $client.send(Pokepay::Request::GetAccount.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"                # account_id: ウォレットID
))
```



### Parameters
#### `account_id`
ウォレットIDです。

フィルターとして使われ、指定したウォレットIDのウォレットを取得します。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>



成功したときは
[AccountDetail](./responses.md#account-detail)
を返します



---


<a name="update-account"></a>
## UpdateAccount: ウォレット情報を更新する
ウォレットの状態を更新します。
以下の項目が変更できます。

- ウォレットの凍結/凍結解除の切り替え(エンドユーザー、店舗ユーザー共通)
- 店舗でチャージ可能かどうか(店舗ユーザのみ)

エンドユーザーのウォレット情報更新には UpdateCustomerAccount が使用できます。

```RUBY
response = $client.send(Pokepay::Request::UpdateAccount.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # account_id: ウォレットID
                          is_suspended: false,                                  # ウォレットが凍結されているかどうか
                          status: "active",                                     # ウォレット状態
                          can_transfer_topup: false                             # チャージ可能かどうか
))
```



### Parameters
#### `account_id`
ウォレットIDです。

指定したウォレットIDのウォレットの状態を更新します。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `is_suspended`
ウォレットの凍結状態です。真にするとウォレットが凍結され、そのウォレットでは新規取引ができなくなります。偽にすると凍結解除されます。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "boolean"
}
```

</details>

#### `status`
ウォレットの状態です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "enum": [
    "active",
    "suspended",
    "pre-closed"
  ]
}
```

</details>

#### `can_transfer_topup`
店舗ユーザーがエンドユーザーにチャージ可能かどうかです。真にするとチャージ可能となり、偽にするとチャージ不可能となります。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "boolean"
}
```

</details>



成功したときは
[AccountDetail](./responses.md#account-detail)
を返します



---


<a name="list-account-balances"></a>
## ListAccountBalances: エンドユーザーの残高内訳を表示する
エンドユーザーのウォレット毎の残高を有効期限別のリストとして取得します。

```RUBY
response = $client.send(Pokepay::Request::ListAccountBalances.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # account_id: ウォレットID
                          page: 3055,                                           # ページ番号
                          per_page: 4465,                                       # 1ページ分の取引数
                          expires_at_from: "2024-06-19T07:28:46.000000Z",       # 有効期限の期間によるフィルター(開始時点)
                          expires_at_to: "2020-07-24T09:53:41.000000Z",         # 有効期限の期間によるフィルター(終了時点)
                          direction: "desc"                                     # 有効期限によるソート順序
))
```



### Parameters
#### `account_id`
ウォレットIDです。

フィルターとして使われ、指定したウォレットIDのウォレット残高を取得します。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `page`
取得したいページ番号です。デフォルト値は1です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer",
  "minimum": 1
}
```

</details>

#### `per_page`
1ページ分のウォレット残高数です。デフォルト値は30です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer",
  "minimum": 1
}
```

</details>

#### `expires_at_from`
有効期限の期間によるフィルターの開始時点のタイムスタンプです。デフォルトでは未指定です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `expires_at_to`
有効期限の期間によるフィルターの終了時点のタイムスタンプです。デフォルトでは未指定です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `direction`
有効期限によるソートの順序を指定します。デフォルト値はasc (昇順)です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "enum": [
    "asc",
    "desc"
  ]
}
```

</details>



成功したときは
[PaginatedAccountBalance](./responses.md#paginated-account-balance)
を返します



---


<a name="list-account-expired-balances"></a>
## ListAccountExpiredBalances: エンドユーザーの失効済みの残高内訳を表示する
エンドユーザーのウォレット毎の失効済みの残高を有効期限別のリストとして取得します。

```RUBY
response = $client.send(Pokepay::Request::ListAccountExpiredBalances.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # account_id: ウォレットID
                          page: 7660,                                           # ページ番号
                          per_page: 2245,                                       # 1ページ分の取引数
                          expires_at_from: "2025-12-29T01:12:28.000000Z",       # 有効期限の期間によるフィルター(開始時点)
                          expires_at_to: "2026-08-29T05:08:18.000000Z",         # 有効期限の期間によるフィルター(終了時点)
                          direction: "desc"                                     # 有効期限によるソート順序
))
```



### Parameters
#### `account_id`
ウォレットIDです。

フィルターとして使われ、指定したウォレットIDのウォレット残高を取得します。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `page`
取得したいページ番号です。デフォルト値は1です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer",
  "minimum": 1
}
```

</details>

#### `per_page`
1ページ分のウォレット残高数です。デフォルト値は30です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer",
  "minimum": 1
}
```

</details>

#### `expires_at_from`
有効期限の期間によるフィルターの開始時点のタイムスタンプです。デフォルトでは未指定です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `expires_at_to`
有効期限の期間によるフィルターの終了時点のタイムスタンプです。デフォルトでは未指定です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `direction`
有効期限によるソートの順序を指定します。デフォルト値はdesc (降順)です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "enum": [
    "asc",
    "desc"
  ]
}
```

</details>



成功したときは
[PaginatedAccountBalance](./responses.md#paginated-account-balance)
を返します



---


<a name="update-customer-account"></a>
## UpdateCustomerAccount: エンドユーザーのウォレット情報を更新する
エンドユーザーのウォレットの状態を更新します。

```RUBY
response = $client.send(Pokepay::Request::UpdateCustomerAccount.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # account_id: ウォレットID
                          status: "pre-closed",                                 # ウォレット状態
                          account_name: "zRf1f9JiZjCJBrJjt5kCWz5zMWjynyv6KSgRW4BSGACMY5nowhDUZD5IZKMp0STmYDwTtHP0EcP6hogkn6nAjgTjLkVtsanieCAlqrCK8PwmGod9YcEsgY2DC2Vj8cKXwgERagqKSGsUKboeeiIHlMnCdyvxKvSOqTvlYodFyg21jiUhByaB66BNcapTyLZWxad9qMqfjUCaVImVTzD7ogGgb", # アカウント名
                          external_id: "buuhXvkkv63jx716j9qY",                  # 外部ID
                          metadata: "{\"key1\":\"foo\",\"key2\":\"bar\"}"       # ウォレットに付加するメタデータ
))
```



### Parameters
#### `account_id`
ウォレットIDです。

指定したウォレットIDのウォレットの状態を更新します。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `status`
ウォレットの状態です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "enum": [
    "active",
    "suspended",
    "pre-closed"
  ]
}
```

</details>

#### `account_name`
変更するウォレット名です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 256
}
```

</details>

#### `external_id`
変更する外部IDです。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 50
}
```

</details>

#### `metadata`
ウォレットに付加するメタデータをJSON文字列で指定します。
指定できるJSON文字列には以下のような制約があります。
- フラットな構造のJSONを文字列化したものであること。
- keyは最大32文字の文字列(同じkeyを複数指定することはできません)
- valueには128文字以下の文字列が指定できます

更新時に指定した内容でメタデータ全体が置き換えられることに注意してください。
例えば、元々のメタデータが以下だったときに、

'{"key1":"foo","key2":"bar"}'

更新APIで以下のように更新するとします。

'{"key1":"baz"}'

このときkey1はfooからbazに更新され、key2に対するデータは消去されます。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "json"
}
```

</details>



成功したときは
[AccountWithUser](./responses.md#account-with-user)
を返します



---


<a name="get-customer-accounts"></a>
## GetCustomerAccounts: エンドユーザーのウォレット一覧を表示する
マネーを指定してエンドユーザーのウォレット一覧を取得します。

```RUBY
response = $client.send(Pokepay::Request::GetCustomerAccounts.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # private_money_id: マネーID
                          page: 6401,                                           # ページ番号
                          per_page: 4098,                                       # 1ページ分のウォレット数
                          created_at_from: "2025-02-04T01:34:00.000000Z",       # ウォレット作成日によるフィルター(開始時点)
                          created_at_to: "2023-05-09T20:33:08.000000Z",         # ウォレット作成日によるフィルター(終了時点)
                          is_suspended: false,                                  # ウォレットが凍結状態かどうかでフィルターする
                          status: "active",                                     # ウォレット状態
                          external_id: "sHY",                                   # 外部ID
                          tel: "06-743124",                                     # エンドユーザーの電話番号
                          email: "kLLFzDvGgw@T6RW.com"                          # エンドユーザーのメールアドレス
))
```



### Parameters
#### `private_money_id`
マネーIDです。

一覧するウォレットのマネーを指定します。このパラメータは必須です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `page`
取得したいページ番号です。デフォルト値は1です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer",
  "minimum": 1
}
```

</details>

#### `per_page`
1ページ分のウォレット数です。デフォルト値は30です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer",
  "minimum": 1
}
```

</details>

#### `created_at_from`
ウォレット作成日によるフィルターの開始時点のタイムスタンプです。デフォルトでは未指定です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `created_at_to`
ウォレット作成日によるフィルターの終了時点のタイムスタンプです。デフォルトでは未指定です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `is_suspended`
このパラメータが指定されている場合、ウォレットの凍結状態で結果がフィルターされます。デフォルトでは未指定です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "boolean"
}
```

</details>

#### `status`
このパラメータが指定されている場合、ウォレットの状態で結果がフィルターされます。デフォルトでは未指定です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "enum": [
    "active",
    "suspended",
    "pre-closed"
  ]
}
```

</details>

#### `external_id`
外部IDでのフィルタリングです。デフォルトでは未指定です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 50
}
```

</details>

#### `tel`
エンドユーザーの電話番号でのフィルタリングです。デフォルトでは未指定です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "pattern": "^0[0-9]{1,3}-?[0-9]{2,4}-?[0-9]{3,4}$"
}
```

</details>

#### `email`
エンドユーザーのメールアドレスでのフィルタリングです。デフォルトでは未指定です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "email"
}
```

</details>



成功したときは
[PaginatedAccountWithUsers](./responses.md#paginated-account-with-users)
を返します

### Error Responses
|status|type|ja|en|
|---|---|---|---|
|403|unpermitted_admin_user|この管理ユーザには権限がありません|Admin does not have permission|
|422|private_money_not_found|マネーが見つかりません|Private money not found|



---


<a name="create-customer-account"></a>
## CreateCustomerAccount: 新規エンドユーザーをウォレットと共に追加する
指定したマネーのウォレットを作成し、同時にそのウォレットを保有するユーザも新規に作成します。
このAPIにより作成されたユーザは認証情報を持たないため、モバイルSDKやポケペイ標準アプリからはログインすることはできません。
Partner APIのみから操作可能な特殊なユーザになります。
システム全体をPartner APIのみで構成する場合にのみ使用してください。

```RUBY
response = $client.send(Pokepay::Request::CreateCustomerAccount.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # private_money_id: マネーID
                          user_name: "ポケペイ太郎",                                  # ユーザー名
                          account_name: "ポケペイ太郎のアカウント",                         # アカウント名
                          external_id: "89"                                     # 外部ID
))
```



### Parameters
#### `private_money_id`
マネーIDです。

これによって作成するウォレットのマネーを指定します。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `user_name`
ウォレットと共に作成するユーザ名です。省略した場合は空文字となります。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 256
}
```

</details>

#### `account_name`
作成するウォレット名です。省略した場合は空文字となります。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 256
}
```

</details>

#### `external_id`
PAPIクライアントシステムから利用するPokepayユーザーのIDです。デフォルトでは未指定です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 50
}
```

</details>



成功したときは
[AccountWithUser](./responses.md#account-with-user)
を返します

### Error Responses
|status|type|ja|en|
|---|---|---|---|
|403|unpermitted_admin_user|この管理ユーザには権限がありません|Admin does not have permission|
|422|user_not_found|ユーザーが見つかりません|The user is not found|
|422|private_money_not_found|マネーが見つかりません|Private money not found|
|422|invalid_metadata|メタデータの形式が不正です|Invalid metadata format|
|422|user_attributes_external_id_not_match|ユーザー属性情報の外部IDが一致しません|Not match external id of user attributes|
|422|user_attributes_not_found|ユーザー属性情報が存在しません|Not found the user attrubtes|
|422|account_closed|アカウントは退会しています|The account is closed|
|422|account_can_not_create|このマネーに新規アカウントを作る事は出来ません|Can not create an account with this money|



---


<a name="get-shop-accounts"></a>
## GetShopAccounts: 店舗ユーザーのウォレット一覧を表示する
マネーを指定して店舗ユーザーのウォレット一覧を取得します。

```RUBY
response = $client.send(Pokepay::Request::GetShopAccounts.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # private_money_id: マネーID
                          page: 8876,                                           # ページ番号
                          per_page: 9549,                                       # 1ページ分のウォレット数
                          created_at_from: "2024-08-26T07:32:59.000000Z",       # ウォレット作成日によるフィルター(開始時点)
                          created_at_to: "2020-03-24T19:22:49.000000Z",         # ウォレット作成日によるフィルター(終了時点)
                          is_suspended: false                                   # ウォレットが凍結状態かどうかでフィルターする
))
```



### Parameters
#### `private_money_id`
マネーIDです。

一覧するウォレットのマネーを指定します。このパラメータは必須です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `page`
取得したいページ番号です。デフォルト値は1です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer",
  "minimum": 1
}
```

</details>

#### `per_page`
1ページ分のウォレット数です。デフォルト値は30です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer",
  "minimum": 1
}
```

</details>

#### `created_at_from`
ウォレット作成日によるフィルターの開始時点のタイムスタンプです。デフォルトでは未指定です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `created_at_to`
ウォレット作成日によるフィルターの終了時点のタイムスタンプです。デフォルトでは未指定です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `is_suspended`
このパラメータが指定されている場合、ウォレットの凍結状態で結果がフィルターされます。デフォルトでは未指定です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "boolean"
}
```

</details>



成功したときは
[PaginatedAccountWithUsers](./responses.md#paginated-account-with-users)
を返します

### Error Responses
|status|type|ja|en|
|---|---|---|---|
|403|unpermitted_admin_user|この管理ユーザには権限がありません|Admin does not have permission|
|422|private_money_not_found|マネーが見つかりません|Private money not found|



---


<a name="get-customer-cards"></a>
## GetCustomerCards: エンドユーザーのクレジットカード一覧を取得する
エンドユーザーのクレジットカード一覧を取得します。
3D Secure認証済みのカードのみが返されます。
idはcredit-sessions作成時に使用できます。

```RUBY
response = $client.send(Pokepay::Request::GetCustomerCards.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # customer_id: エンドユーザーID
                          page: 8750,                                           # ページ番号
                          per_page: 7                                           # 1ページ分の要素数
))
```



### Parameters
#### `customer_id`
エンドユーザーのIDです。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `page`
取得したいページ番号です。デフォルト値は1です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer",
  "minimum": 1
}
```

</details>

#### `per_page`
1ページ当たりの要素数です。デフォルト値は30です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer",
  "minimum": 1,
  "maximum": 100
}
```

</details>



成功したときは
[PaginatedUserCards](./responses.md#paginated-user-cards)
を返します



---


<a name="create-customer-card"></a>
## CreateCustomerCard: エンドユーザーのクレジットカードを登録する
エンドユーザーのクレジットカードを登録します。
会員登録がまだの場合は同時に会員登録も行います。

```RUBY
response = $client.send(Pokepay::Request::CreateCustomerCard.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # customer_id: エンドユーザーID
                          "p03GIkT",                                            # token: MDKトークン
                          is_cardholder_name_specified: true                    # カード名義人指定フラグ
))
```



### Parameters
#### `customer_id`
カード保持者であるエンドユーザーのIDです。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `token`
カード情報に紐付くMDKトークンです。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string"
}
```

</details>

#### `is_cardholder_name_specified`
MDKトークン作成時にカード名義人を指定したかどうかのフラグです。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "boolean"
}
```

</details>



成功したときは
[UserCard](./responses.md#user-card)
を返します



---


<a name="delete-customer-card"></a>
## DeleteCustomerCard: エンドユーザーのクレジットカードを削除する
エンドユーザーの登録済みクレジットカードを削除します。
対象カードにアクティブなクレジットセッションがある場合は削除できません。

```RUBY
response = $client.send(Pokepay::Request::DeleteCustomerCard.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # customer_id: エンドユーザーID
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"                # card_uuid: カード識別子
))
```



### Parameters
#### `customer_id`
カード保持者であるエンドユーザーのIDです。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `card_uuid`
削除対象カードのUUID（カード一覧の id）です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>



成功したときは
[CustomerCardDeleted](./responses.md#customer-card-deleted)
を返します



---


<a name="credit-card-topup-with-membership"></a>
## CreditCardTopupWithMembership: 登録済みクレジットカードでチャージする（3Dセキュア）
エンドユーザーの登録済みクレジットカードを使い、3Dセキュア認証付きでチャージします。
レスポンスの authentication_html をエンドユーザーのブラウザに出力し認証を行ってください。
receiver_user_id を指定すると、カード保持者と異なるユーザーの口座にチャージできます。

```RUBY
response = $client.send(Pokepay::Request::CreditCardTopupWithMembership.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # customer_id: カード保持者のエンドユーザーID
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # card_uuid: カード識別子
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # private_money_id: マネーID
                          8194,                                                 # amount: チャージ金額
                          receiver_user_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # チャージ先ユーザーID
                          delete_card_if_auth_fail: true,                       # 認証失敗時にカードを削除するか
                          description: "クレジットカードチャージ",                          # 取引履歴に表示する説明文
                          return_url: "https://example.com/charge/complete?session=abc", # 3Dセキュア完了画面の戻り先URL
                          request_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",   # リクエストID
                          topup_quota_id: 7861,                                 # チャージ可能枠ID
                          memo1: "campaign2026summer",                          # 取引メモ1
                          memo2: "gG98parY1MjhjRY8lQm64kRr3kH8p4zRh22j",        # 取引メモ2
                          memo3: "pb6A04q8CuE1owZlOUOp5DvgrS",                  # 取引メモ3
                          freekey: "order20260803001"                           # キー情報
))
```



### Parameters
#### `customer_id`
クレジットカードを保持するエンドユーザーのIDです。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `card_uuid`
使用する登録済みカードのUUID（カード一覧の id）です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `private_money_id`
チャージ先口座のマネーIDです。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `receiver_user_id`
チャージ先のエンドユーザーIDです。
省略時はカード保持者本人にチャージします。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `amount`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer",
  "minimum": 1
}
```

</details>

#### `delete_card_if_auth_fail`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "boolean"
}
```

</details>

#### `description`
取引説明文です。

任意入力で、3Dセキュア認証成功後に作成されるチャージ取引の取引履歴に表示されます。
省略した場合、および空文字列を指定した場合は既定の説明文が使われます
(取引説明文を空にすることはできません)。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 200
}
```

</details>

#### `return_url`
3Dセキュア完了画面(成功・失敗いずれも)に表示する「戻る」ボタンの遷移先URLです。

任意入力です。指定した場合のみボタンが表示され、エンドユーザーが押すと
このURLへ遷移します。省略した場合、および空文字列を指定した場合は
ボタンを表示しません。

スキームは http または https のみ受け付けます。それ以外の値、および
2048文字を超える値は invalid_parameters エラー
(invalid: ["return_url"]、エラーコード400) になります。
ポケペイ側でクエリパラメータの付与は行いません。取引を識別したい場合は
URL自体にパラメータを含めてください。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "url",
  "maxLength": 2048
}
```

</details>

#### `request_id`
冪等性のためのリクエストIDです。省略時はサーバーが生成します。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `topup_quota_id`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer"
}
```

</details>

#### `memo1`
Veritransの取引に付与する取引メモです。

任意入力で、半角英数字100文字以内で指定します。
Veritransの取引検索で参照できます。ポケペイの取引履歴には表示されません。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 100,
  "pattern": "^[0-9A-Za-z]*$"
}
```

</details>

#### `memo2`
Veritransの取引に付与する取引メモです。

任意入力で、半角英数字100文字以内で指定します。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 100,
  "pattern": "^[0-9A-Za-z]*$"
}
```

</details>

#### `memo3`
Veritransの取引に付与する取引メモです。

任意入力で、半角英数字100文字以内で指定します。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 100,
  "pattern": "^[0-9A-Za-z]*$"
}
```

</details>

#### `freekey`
Veritransの取引に付与するキー情報です。

任意入力で、半角英数字256桁以内で指定します。
加盟店システムで管理しているIDとVeritransの取引を紐付ける用途に使えます。
ハイフンやアンダースコアは使用できないため、UUIDをそのまま指定することはできません。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 256,
  "pattern": "^[0-9A-Za-z]*$"
}
```

</details>



成功したときは
[CardAuthorizeResult](./responses.md#card-authorize-result)
を返します



---


<a name="credit-card-topup-with-mdk-token"></a>
## CreditCardTopupWithMdkToken: 未登録クレジットカード（MDKトークン）でチャージする（3Dセキュア）
MDKトークンで表されるクレジットカードを使い、カード登録なしで3Dセキュア認証付きチャージを行います。
レスポンスの authentication_html をエンドユーザーのブラウザに出力し認証を行ってください。
receiver_user_id を指定すると、カード保持者と異なるユーザーの口座にチャージできます。

```RUBY
response = $client.send(Pokepay::Request::CreditCardTopupWithMdkToken.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # customer_id: カード保持者のエンドユーザーID
                          "VQxP0FMe",                                           # token: MDKトークン
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # private_money_id: マネーID
                          9929,                                                 # amount: チャージ金額
                          receiver_user_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # チャージ先ユーザーID
                          is_cardholder_name_specified: true,                   # カード名義人指定フラグ
                          description: "クレジットカードチャージ",                          # 取引履歴に表示する説明文
                          return_url: "https://example.com/charge/complete?session=abc", # 3Dセキュア完了画面の戻り先URL
                          request_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",   # リクエストID
                          topup_quota_id: 1594,                                 # チャージ可能枠ID
                          memo1: "campaign2026summer",                          # 取引メモ1
                          memo2: "V9EqbRbd24Rj7u6pC11OaLaok9IPibnVjx3d7rpYA3FDQftTHP", # 取引メモ2
                          memo3: "VTC07Ueq0YinBn9N01Zd8p44vXX3sPd3XUtKZ0VF82E372K2wtSRG3m4H0mlZ2BnVRK59rd81H5yjrE3Fq04SWnew49o1LMr", # 取引メモ3
                          freekey: "order20260803001"                           # キー情報
))
```



### Parameters
#### `customer_id`
クレジットカードを保持するエンドユーザーのIDです。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `token`
VeritransのMDKトークンです。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string"
}
```

</details>

#### `private_money_id`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `receiver_user_id`
省略時はカード保持者本人にチャージします。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `amount`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer",
  "minimum": 1
}
```

</details>

#### `is_cardholder_name_specified`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "boolean"
}
```

</details>

#### `description`
取引説明文です。

任意入力で、3Dセキュア認証成功後に作成されるチャージ取引の取引履歴に表示されます。
省略した場合、および空文字列を指定した場合は既定の説明文が使われます
(取引説明文を空にすることはできません)。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 200
}
```

</details>

#### `return_url`
3Dセキュア完了画面(成功・失敗いずれも)に表示する「戻る」ボタンの遷移先URLです。

任意入力です。指定した場合のみボタンが表示され、エンドユーザーが押すと
このURLへ遷移します。省略した場合、および空文字列を指定した場合は
ボタンを表示しません。

スキームは http または https のみ受け付けます。それ以外の値、および
2048文字を超える値は invalid_parameters エラー
(invalid: ["return_url"]、エラーコード400) になります。
ポケペイ側でクエリパラメータの付与は行いません。取引を識別したい場合は
URL自体にパラメータを含めてください。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "url",
  "maxLength": 2048
}
```

</details>

#### `request_id`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `topup_quota_id`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer"
}
```

</details>

#### `memo1`
Veritransの取引に付与する取引メモです。

任意入力で、半角英数字100文字以内で指定します。
Veritransの取引検索で参照できます。ポケペイの取引履歴には表示されません。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 100,
  "pattern": "^[0-9A-Za-z]*$"
}
```

</details>

#### `memo2`
Veritransの取引に付与する取引メモです。

任意入力で、半角英数字100文字以内で指定します。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 100,
  "pattern": "^[0-9A-Za-z]*$"
}
```

</details>

#### `memo3`
Veritransの取引に付与する取引メモです。

任意入力で、半角英数字100文字以内で指定します。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 100,
  "pattern": "^[0-9A-Za-z]*$"
}
```

</details>

#### `freekey`
Veritransの取引に付与するキー情報です。

任意入力で、半角英数字256桁以内で指定します。
加盟店システムで管理しているIDとVeritransの取引を紐付ける用途に使えます。
ハイフンやアンダースコアは使用できないため、UUIDをそのまま指定することはできません。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 256,
  "pattern": "^[0-9A-Za-z]*$"
}
```

</details>



成功したときは
[CardAuthorizeResult](./responses.md#card-authorize-result)
を返します



---


<a name="list-customer-transactions"></a>
## ListCustomerTransactions: 取引履歴を取得する
取引一覧を返します。

```RUBY
response = $client.send(Pokepay::Request::ListCustomerTransactions.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # private_money_id: マネーID
                          sender_customer_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # 送金エンドユーザーID
                          receiver_customer_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", # 受取エンドユーザーID
                          type: "cashback",                                     # 取引種別
                          is_modified: false,                                   # キャンセル済みかどうか
                          from: "2026-06-12T03:17:15.000000Z",                  # 開始日時
                          to: "2026-06-27T09:52:37.000000Z",                    # 終了日時
                          page: 1,                                              # ページ番号
                          per_page: 50                                          # 1ページ分の取引数
))
```



### Parameters
#### `private_money_id`
マネーIDです。
フィルターとして使われ、指定したマネーでの取引のみ一覧に表示されます。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `sender_customer_id`
送金ユーザーIDです。

フィルターとして使われ、指定された送金ユーザーでの取引のみ一覧に表示されます。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `receiver_customer_id`
受取ユーザーIDです。

フィルターとして使われ、指定された受取ユーザーでの取引のみ一覧に表示されます。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `type`
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
5. cashback
   ウォレット退会時返金
6. expire
   ウォレット退会時失効

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "enum": [
    "topup",
    "payment",
    "exchange",
    "transfer",
    "cashback",
    "expire"
  ]
}
```

</details>

#### `is_modified`
キャンセル済みかどうかを判定するフラグです。

これにtrueを指定するとキャンセルされた取引のみ一覧に表示されます。
falseを指定するとキャンセルされていない取引のみ一覧に表示されます
何も指定しなければキャンセルの有無にかかわらず一覧に表示されます。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "boolean"
}
```

</details>

#### `from`
抽出期間の開始日時です。

フィルターとして使われ、開始日時以降に発生した取引のみ一覧に表示されます。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `to`
抽出期間の終了日時です。

フィルターとして使われ、終了日時以前に発生した取引のみ一覧に表示されます。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `page`
取得したいページ番号です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer",
  "minimum": 1
}
```

</details>

#### `per_page`
1ページ分の取引数です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer",
  "minimum": 1
}
```

</details>



成功したときは
[PaginatedTransaction](./responses.md#paginated-transaction)
を返します

### Error Responses
|status|type|ja|en|
|---|---|---|---|
|403|unpermitted_admin_user|この管理ユーザには権限がありません|Admin does not have permission|
|422|customer_user_not_found||The customer user is not found|
|422|private_money_not_found|マネーが見つかりません|Private money not found|
|503|temporarily_unavailable||Service Unavailable|



---



