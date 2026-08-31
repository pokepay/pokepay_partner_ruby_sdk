# SevenBankATMSession
セブンATMチャージの取引内容を照会するAPIを提供しています。

<a name="get-seven-bank-atm-session"></a>
## GetSevenBankATMSession: セブン銀行ATMセッションの取得
セブン銀行ATMセッションを取得します

```RUBY
response = $client.send(Pokepay::Request::GetSevenBankAtmSession.new(
                          "4D21T3szc"                                           # qr_info: QRコードの情報
))
```



### Parameters
#### `qr_info`
取得するセブン銀行ATMチャージのQRコードの情報です。

<details>
<summary>スキーマ</summary>

```json
{
  "type": "string"
}
```

</details>



成功したときは
[SevenBankATMSession](./responses.md#seven-bank-atm-session)
を返します



---



