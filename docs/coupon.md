# Coupon
割引クーポンを表すデータです。
クーポンをユーザが明示的に利用することによって支払い決済時の割引(固定金額 or 割引率)が適用されます。
クーポンは支払い時に指定し、支払い処理の前にクーポンに指定の方法で値引き処理を行います。
クーポン原資を負担する発行店舗を設定したり、配布先を指定することも可能です。
また、特定店舗で利用できるものや利用可能期間、配信条件などを設定できます。


<a name="list-coupons"></a>
## ListCoupons: クーポン一覧の取得
指定したマネーのクーポン一覧を取得します

```RUBY
response = $client.send(Pokepay::Request::ListCoupons.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # private_money_id: 対象クーポンのマネーID
                          coupon_id: "IL",                                      # クーポンID
                          coupon_name: "QMz1SY",                                # クーポン名
                          issued_shop_name: "bigi3uqG",                         # 発行店舗名
                          available_shop_name: "y9JaET7y",                      # 利用可能店舗名
                          available_from: "2021-12-05T10:39:58.000000Z",        # 利用可能期間 (開始日時)
                          available_to: "2024-04-29T05:00:17.000000Z",          # 利用可能期間 (終了日時)
                          page: 1,                                              # ページ番号
                          per_page: 50                                          # 1ページ分の取得数
))
```



### Parameters
#### `private_money_id`
対象クーポンのマネーIDです(必須項目)。
存在しないマネーIDを指定した場合はprivate_money_not_foundエラー(422)が返ります。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `coupon_id`
指定されたクーポンIDで結果をフィルターします。
部分一致(前方一致)します。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string"
}
```

</details>

#### `coupon_name`
指定されたクーポン名で結果をフィルターします。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string"
}
```

</details>

#### `issued_shop_name`
指定された発行店舗で結果をフィルターします。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string"
}
```

</details>

#### `available_shop_name`
指定された利用可能店舗で結果をフィルターします。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string"
}
```

</details>

#### `available_from`
利用可能期間でフィルターします。フィルターの開始日時をISO8601形式で指定します。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `available_to`
利用可能期間でフィルターします。フィルターの終了日時をISO8601形式で指定します。

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
1ページ分の取得数です。デフォルトでは 50 になっています。

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
[PaginatedCoupons](./responses.md#paginated-coupons)
を返します

### Error Responses
|status|type|ja|en|
|---|---|---|---|
|403|unpermitted_admin_user|この管理ユーザには権限がありません|Admin does not have permission|
|422|shop_user_not_found|店舗が見つかりません|The shop user is not found|
|422|private_money_not_found|マネーが見つかりません|Private money not found|



---


<a name="create-coupon"></a>
## CreateCoupon: クーポンの登録
新しいクーポンを登録します

```RUBY
response = $client.send(Pokepay::Request::CreateCoupon.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                          "I77xfyzjZfk3Eg446tN2eZbvNHRD",
                          "2026-03-02T06:50:11.000000Z",
                          "2026-06-13T06:30:51.000000Z",
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # issued_shop_id: 発行元の店舗ID
                          description: "Ww9qEb2szCXBkkHRCtXprtOEGF7FA7qtYAU5XoCNIUER98LHSRVry41mwGLHNUS9ycac0Neld0xGYOxpvYgvz5c96ZecqU3VE5SiDh8XYp2Sb6qswUL8UZ6V9wGI85BEYoVTObCbAWlB9ZTLlBVIhK6pPNqnVaACzTnU4fw9nHGh382d4IcuvP4sfykROqGA2kGIKWn7WmxLFKf1vULaBahAeJdLNgTdHrnXru0CK861yZBwzeo",
                          discount_amount: 2425,
                          discount_percentage: 5484.0,
                          discount_upper_limit: 1757,
                          display_starts_at: "2022-11-25T07:13:26.000000Z",     # クーポンの掲載期間(開始日時)
                          display_ends_at: "2022-10-27T13:13:18.000000Z",       # クーポンの掲載期間(終了日時)
                          is_disabled: false,                                   # 無効化フラグ
                          is_hidden: true,                                      # クーポン一覧に掲載されるかどうか
                          is_public: true,                                      # アプリ配信なしで受け取れるかどうか
                          code: "V0HOJ5Mg",                                     # クーポン受け取りコード
                          usage_limit: 8756,                                    # ユーザごとの利用可能回数(NULLの場合は無制限)
                          min_amount: 588,                                      # クーポン適用可能な最小取引額
                          is_shop_specified: false,                             # 特定店舗限定のクーポンかどうか
                          available_shop_ids: ["xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"], # 利用可能店舗リスト
                          storage_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",   # ストレージID
                          num_recipients_cap: 2874                              # クーポンを受け取ることができるユーザ数上限
))
```

`is_shop_specified`と`available_shop_ids`は同時に指定する必要があります。


### Parameters
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

#### `name`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 128
}
```

</details>

#### `description`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 256
}
```

</details>

#### `discount_amount`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer",
  "minimum": 0
}
```

</details>

#### `discount_percentage`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "number",
  "minimum": 0
}
```

</details>

#### `discount_upper_limit`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer",
  "minimum": 0
}
```

</details>

#### `starts_at`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `ends_at`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `display_starts_at`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `display_ends_at`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `is_disabled`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "boolean"
}
```

</details>

#### `is_hidden`
アプリに表示されるクーポン一覧に掲載されるかどうか。
主に一時的に掲載から外したいときに用いられる。そのためis_publicの設定よりも優先される。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "boolean"
}
```

</details>

#### `is_public`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "boolean"
}
```

</details>

#### `code`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string"
}
```

</details>

#### `usage_limit`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer"
}
```

</details>

#### `min_amount`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer"
}
```

</details>

#### `issued_shop_id`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `is_shop_specified`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "boolean"
}
```

</details>

#### `available_shop_ids`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "array",
  "items": {
    "type": "string",
    "format": "uuid"
  }
}
```

</details>

#### `storage_id`
Storage APIでアップロードしたクーポン画像のStorage IDを指定します

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `num_recipients_cap`

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
[CouponDetail](./responses.md#coupon-detail)
を返します

### Error Responses
|status|type|ja|en|
|---|---|---|---|
|400|invalid_parameters|項目が無効です|Invalid parameters|
|403|unpermitted_admin_user|この管理ユーザには権限がありません|Admin does not have permission|
|404|partner_storage_not_found|指定したIDのデータは保存されていません|Not found by storage_id|
|422|shop_user_not_found|店舗が見つかりません|The shop user is not found|
|422|private_money_not_found|マネーが見つかりません|Private money not found|
|422|coupon_image_storage_conflict|クーポン画像のストレージIDは既に存在します|The coupon image storage_id is already exists|



---


<a name="get-coupon"></a>
## GetCoupon: クーポンの取得
指定したIDを持つクーポンを取得します

```RUBY
response = $client.send(Pokepay::Request::GetCoupon.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"                # coupon_id: クーポンID
))
```



### Parameters
#### `coupon_id`
取得するクーポンのIDです。
UUIDv4フォーマットである必要があり、フォーマットが異なる場合は InvalidParametersエラー(400)が返ります。
指定したIDのクーポンが存在しない場合はCouponNotFoundエラー(422)が返ります。

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
[CouponDetail](./responses.md#coupon-detail)
を返します



---


<a name="update-coupon"></a>
## UpdateCoupon: クーポンの更新
指定したクーポンを更新します

```RUBY
response = $client.send(Pokepay::Request::UpdateCoupon.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # coupon_id: クーポンID
                          name: "d5pOMZG0Q1epC2P9o6ZPNLGB22OwLCnaLili3chmVxHdB9QfCurmIpiTiNJmdhSFJZDo3oq9jSUkc9PdtCnJGKBJDfwGwTHxDL2bOdXfkEBpMjbp",
                          description: "PBsioaYW8Yi4hZj4xdPTFTA02UZKecENyKp2Io7TZBqCIqL4rp2EFrfcK15LTb24Ur3nzPNHJH0RK2HZRZXaO0yBwCPt9KlGpQkqx0Eg2tYlbUkqmQv60CMZa5pywmhrY89J06nrffjpXgwax0yxzxVt1fgZx65QyqRA0ErxUFPGG3NtnfgRNPusLiOWBNvfaPU2",
                          discount_amount: 4784,
                          discount_percentage: 3772.0,
                          discount_upper_limit: 4013,
                          starts_at: "2024-09-05T17:32:56.000000Z",
                          ends_at: "2021-08-09T18:10:29.000000Z",
                          display_starts_at: "2023-08-16T01:55:15.000000Z",     # クーポンの掲載期間(開始日時)
                          display_ends_at: "2023-04-07T14:51:29.000000Z",       # クーポンの掲載期間(終了日時)
                          is_disabled: true,                                    # 無効化フラグ
                          is_hidden: false,                                     # クーポン一覧に掲載されるかどうか
                          is_public: true,                                      # アプリ配信なしで受け取れるかどうか
                          code: "mjHr0s",                                       # クーポン受け取りコード
                          usage_limit: 5546,                                    # ユーザごとの利用可能回数(NULLの場合は無制限)
                          min_amount: 6414,                                     # クーポン適用可能な最小取引額
                          is_shop_specified: true,                              # 特定店舗限定のクーポンかどうか
                          available_shop_ids: ["xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"], # 利用可能店舗リスト
                          storage_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",   # ストレージID
                          num_recipients_cap: 1776                              # クーポンを受け取ることができるユーザ数上限
))
```


`discount_amount`と`discount_percentage`の少なくとも一方は指定する必要があります。



### Parameters
#### `coupon_id`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `name`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 128
}
```

</details>

#### `description`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "maxLength": 256
}
```

</details>

#### `discount_amount`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer",
  "minimum": 0
}
```

</details>

#### `discount_percentage`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "number",
  "minimum": 0
}
```

</details>

#### `discount_upper_limit`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer",
  "minimum": 0
}
```

</details>

#### `starts_at`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `ends_at`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `display_starts_at`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `display_ends_at`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "date-time"
}
```

</details>

#### `is_disabled`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "boolean"
}
```

</details>

#### `is_hidden`
アプリに表示されるクーポン一覧に掲載されるかどうか。
主に一時的に掲載から外したいときに用いられる。そのためis_publicの設定よりも優先される。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "boolean"
}
```

</details>

#### `is_public`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "boolean"
}
```

</details>

#### `code`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string"
}
```

</details>

#### `usage_limit`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer"
}
```

</details>

#### `min_amount`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "integer"
}
```

</details>

#### `is_shop_specified`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "boolean"
}
```

</details>

#### `available_shop_ids`

<details>
<summary>スキーマ</summary>

```json
{
  "type": "array",
  "items": {
    "type": "string",
    "format": "uuid"
  }
}
```

</details>

#### `storage_id`
Storage APIでアップロードしたクーポン画像のStorage IDを指定します

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string",
  "format": "uuid"
}
```

</details>

#### `num_recipients_cap`

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
[CouponDetail](./responses.md#coupon-detail)
を返します



---



