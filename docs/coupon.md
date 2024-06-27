# Coupon
Couponは支払い時に指定し、支払い処理の前にCouponに指定の方法で値引き処理を行います。
Couponは特定店舗で利用できるものや利用可能期間、配信条件などを設定できます。


<a name="list-coupons"></a>
## ListCoupons: クーポン一覧の取得
指定したマネーのクーポン一覧を取得します

```RUBY
response = $client.send(Pokepay::Request::ListCoupons.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # private_money_id: 対象クーポンのマネーID
                          coupon_id: "aTBcNwqa",                                # クーポンID
                          coupon_name: "eR",                                    # クーポン名
                          issued_shop_name: "H16a",                             # 発行店舗名
                          available_shop_name: "zzUqrHd",                       # 利用可能店舗名
                          available_from: "2022-10-31T12:14:13.000000Z",        # 利用可能期間 (開始日時)
                          available_to: "2020-11-15T19:09:39.000000Z",          # 利用可能期間 (終了日時)
                          page: 1,                                              # ページ番号
                          per_page: 50                                          # 1ページ分の取得数
))
```



### Parameters
**`private_money_id`** 
  

対象クーポンのマネーIDです(必須項目)。
存在しないマネーIDを指定した場合はprivate_money_not_foundエラー(422)が返ります。


```json
{
  "type": "string",
  "format": "uuid"
}
```

**`coupon_id`** 
  

指定されたクーポンIDで結果をフィルターします。
部分一致(前方一致)します。


```json
{
  "type": "string"
}
```

**`coupon_name`** 
  

指定されたクーポン名で結果をフィルターします。


```json
{
  "type": "string"
}
```

**`issued_shop_name`** 
  

指定された発行店舗で結果をフィルターします。


```json
{
  "type": "string"
}
```

**`available_shop_name`** 
  

指定された利用可能店舗で結果をフィルターします。


```json
{
  "type": "string"
}
```

**`available_from`** 
  

利用可能期間でフィルターします。フィルターの開始日時をISO8601形式で指定します。


```json
{
  "type": "string",
  "format": "date-time"
}
```

**`available_to`** 
  

利用可能期間でフィルターします。フィルターの終了日時をISO8601形式で指定します。


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
  

1ページ分の取得数です。デフォルトでは 50 になっています。

```json
{
  "type": "integer",
  "minimum": 1
}
```



成功したときは
[PaginatedCoupons](./responses.md#paginated-coupons)
を返します

### Error Responses
|status|type|ja|en|
|---|---|---|---|
|403|unpermitted_admin_user|この管理ユーザには権限がありません|Admin does not have permission|
|422|shop_user_not_found|店舗が見つかりません|The shop user is not found|
|422|private_money_not_found||Private money not found|



---


<a name="create-coupon"></a>
## CreateCoupon: クーポンの登録
新しいクーポンを登録します

```RUBY
response = $client.send(Pokepay::Request::CreateCoupon.new(
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                          "dbmLywqukvEUDGTtuu5mLHhGQ9yekqoyNLKN2h7BNq3rRMob2yqEgXsKX0DNjA5LloLW2ZGwT",
                          "2024-01-10T12:48:58.000000Z",
                          "2024-04-05T18:04:49.000000Z",
                          "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",               # issued_shop_id: 発行元の店舗ID
                          description: "g0EGo2tY0BvAArU4c3Hcr3rYtMZs1YhEQlphw1DkmThPoIdPA7X1r8JTPyIk7mw82VAIRkHcNMgqN77FQwuiGtQW4pnFSkfz0ZAYuHKErS89ga8rAwXpAiqwTxt1HL4wWzmkMDA4SVfWD13Zj3L9DQPYajb0tVdWEdtL2ujHbA770c9iXi2Q1VWdznJovLhT0BrHH",
                          discount_amount: 7287,
                          discount_percentage: 2972.0,
                          discount_upper_limit: 307,
                          display_starts_at: "2022-12-23T11:36:32.000000Z",     # クーポンの掲載期間(開始日時)
                          display_ends_at: "2023-07-14T10:35:16.000000Z",       # クーポンの掲載期間(終了日時)
                          is_disabled: true,                                    # 無効化フラグ
                          is_hidden: false,                                     # クーポン一覧に掲載されるかどうか
                          is_public: true,                                      # アプリ配信なしで受け取れるかどうか
                          code: "OJ",                                           # クーポン受け取りコード
                          usage_limit: 6618,                                    # ユーザごとの利用可能回数(NULLの場合は無制限)
                          min_amount: 99,                                       # クーポン適用可能な最小取引額
                          is_shop_specified: true,                              # 特定店舗限定のクーポンかどうか
                          available_shop_ids: ["xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"], # 利用可能店舗リスト
                          storage_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"    # ストレージID
))
```

`is_shop_specified`と`available_shop_ids`は同時に指定する必要があります。


### Parameters
**`private_money_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```

**`name`** 
  


```json
{
  "type": "string",
  "maxLength": 128
}
```

**`description`** 
  


```json
{
  "type": "string",
  "maxLength": 256
}
```

**`discount_amount`** 
  


```json
{
  "type": "integer",
  "minimum": 0
}
```

**`discount_percentage`** 
  


```json
{
  "type": "number",
  "minimum": 0
}
```

**`discount_upper_limit`** 
  


```json
{
  "type": "integer",
  "minimum": 0
}
```

**`starts_at`** 
  


```json
{
  "type": "string",
  "format": "date-time"
}
```

**`ends_at`** 
  


```json
{
  "type": "string",
  "format": "date-time"
}
```

**`display_starts_at`** 
  


```json
{
  "type": "string",
  "format": "date-time"
}
```

**`display_ends_at`** 
  


```json
{
  "type": "string",
  "format": "date-time"
}
```

**`is_disabled`** 
  


```json
{
  "type": "boolean"
}
```

**`is_hidden`** 
  

アプリに表示されるクーポン一覧に掲載されるかどうか。
主に一時的に掲載から外したいときに用いられる。そのためis_publicの設定よりも優先される。


```json
{
  "type": "boolean"
}
```

**`is_public`** 
  


```json
{
  "type": "boolean"
}
```

**`code`** 
  


```json
{
  "type": "string"
}
```

**`usage_limit`** 
  


```json
{
  "type": "integer"
}
```

**`min_amount`** 
  


```json
{
  "type": "integer"
}
```

**`issued_shop_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```

**`is_shop_specified`** 
  


```json
{
  "type": "boolean"
}
```

**`available_shop_ids`** 
  


```json
{
  "type": "array",
  "items": {
    "type": "string",
    "format": "uuid"
  }
}
```

**`storage_id`** 
  

Storage APIでアップロードしたクーポン画像のStorage IDを指定します

```json
{
  "type": "string",
  "format": "uuid"
}
```



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
|422|private_money_not_found||Private money not found|
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
**`coupon_id`** 
  

取得するクーポンのIDです。
UUIDv4フォーマットである必要があり、フォーマットが異なる場合は InvalidParametersエラー(400)が返ります。
指定したIDのクーポンが存在しない場合はCouponNotFoundエラー(422)が返ります。

```json
{
  "type": "string",
  "format": "uuid"
}
```



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
                          name: "FBg2EP1IMpzVlOR0ZjHbJ4pIYeH1mIjK91BovJNiyan2Rg9xEgMUhIRyB0Lq7z8Ljil9JSMA7r",
                          description: "7mkLLtmKfguDK2IgQjODYIDOJbPEulQIvNSkQALktsxpQNr6y6a28m0nRuldHpSuEU",
                          discount_amount: 2688,
                          discount_percentage: 2032.0,
                          discount_upper_limit: 219,
                          starts_at: "2020-07-25T20:38:40.000000Z",
                          ends_at: "2022-09-15T12:17:45.000000Z",
                          display_starts_at: "2023-08-29T04:46:18.000000Z",     # クーポンの掲載期間(開始日時)
                          display_ends_at: "2021-09-01T09:25:27.000000Z",       # クーポンの掲載期間(終了日時)
                          is_disabled: false,                                   # 無効化フラグ
                          is_hidden: true,                                      # クーポン一覧に掲載されるかどうか
                          is_public: true,                                      # アプリ配信なしで受け取れるかどうか
                          code: "qQ2GFfC0at",                                   # クーポン受け取りコード
                          usage_limit: 5945,                                    # ユーザごとの利用可能回数(NULLの場合は無制限)
                          min_amount: 4970,                                     # クーポン適用可能な最小取引額
                          is_shop_specified: false,                             # 特定店舗限定のクーポンかどうか
                          available_shop_ids: ["xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"], # 利用可能店舗リスト
                          storage_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"    # ストレージID
))
```


`discount_amount`と`discount_percentage`の少なくとも一方は指定する必要があります。



### Parameters
**`coupon_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```

**`name`** 
  


```json
{
  "type": "string",
  "maxLength": 128
}
```

**`description`** 
  


```json
{
  "type": "string",
  "maxLength": 256
}
```

**`discount_amount`** 
  


```json
{
  "type": "integer",
  "minimum": 0
}
```

**`discount_percentage`** 
  


```json
{
  "type": "number",
  "minimum": 0
}
```

**`discount_upper_limit`** 
  


```json
{
  "type": "integer",
  "minimum": 0
}
```

**`starts_at`** 
  


```json
{
  "type": "string",
  "format": "date-time"
}
```

**`ends_at`** 
  


```json
{
  "type": "string",
  "format": "date-time"
}
```

**`display_starts_at`** 
  


```json
{
  "type": "string",
  "format": "date-time"
}
```

**`display_ends_at`** 
  


```json
{
  "type": "string",
  "format": "date-time"
}
```

**`is_disabled`** 
  


```json
{
  "type": "boolean"
}
```

**`is_hidden`** 
  

アプリに表示されるクーポン一覧に掲載されるかどうか。
主に一時的に掲載から外したいときに用いられる。そのためis_publicの設定よりも優先される。


```json
{
  "type": "boolean"
}
```

**`is_public`** 
  


```json
{
  "type": "boolean"
}
```

**`code`** 
  


```json
{
  "type": "string"
}
```

**`usage_limit`** 
  


```json
{
  "type": "integer"
}
```

**`min_amount`** 
  


```json
{
  "type": "integer"
}
```

**`is_shop_specified`** 
  


```json
{
  "type": "boolean"
}
```

**`available_shop_ids`** 
  


```json
{
  "type": "array",
  "items": {
    "type": "string",
    "format": "uuid"
  }
}
```

**`storage_id`** 
  

Storage APIでアップロードしたクーポン画像のStorage IDを指定します

```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[CouponDetail](./responses.md#coupon-detail)
を返します



---



