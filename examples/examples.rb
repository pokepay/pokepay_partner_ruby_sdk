# coding: utf-8
require "pokepay_partner_ruby_sdk"

c = Pokepay::Client.new("~/.pokepay/config.ini")
res = c.send(Pokepay::Request::SendEcho.new('hello'))
res = c.send(Pokepay::Request::ListTransactions.new({'per_page'=>1}))

shop_id = "8b9fbece-73fa-494d-bad5-c7fd9e52f9a0"
customer_id = "78e56df5-dd71-4554-86e5-b0eb8d3781cb"
private_money_id = "4b138a4c-8944-4f98-a5c4-96d3c1c415eb"
money_amount = 100
point_amount = 200
description = "チャージテスト"
response = c.send(Pokepay::Request::CreateTransaction.new(
                    shop_id, customer_id, private_money_id,
                    money_amount, point_amount, description))
