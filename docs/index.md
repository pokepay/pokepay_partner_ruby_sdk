# Installation

```
$ bundle exec rake install
```

# Settings

# Getting Started

```ruby
require "pokepay_partner_ruby_sdk"
c = Pokepay::Client.new("/path/to/config.ini")
res = c.send(Pokepay::Request::SendEcho.new('hello'))
res = c.send(Pokepay::Request::ListTransactions.new({'per_page'=>1}))
res = c.send(Pokepay::Request::CreateTransaction.new(
               "8b9fbece-73fa-494d-bad5-c7fd9e52f9a0",
               "78e56df5-dd71-4554-86e5-b0eb8d3781cb",
               "4b138a4c-8944-4f98-a5c4-96d3c1c415eb",
               100,
               200,
               "チャージテスト"))
```

# Run test

```
$ bundle exec ruby test/pokepay_partner_ruby_sdk_test.rb
```
