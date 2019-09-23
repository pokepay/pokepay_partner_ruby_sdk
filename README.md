# PokepayPartnerRubySdk

Pokepay Partner API SDK for Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pokepay_partner_ruby_sdk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pokepay_partner_ruby_sdk

## Usage

```ruby
require "pokepay_partner_ruby_sdk"
c = Pokepay::Client.new("/path/to/config.ini")
res = c.send(Pokepay::Request::SendEcho.new('hello'))
res = c.send(Pokepay::Request::ListTransactions.new({'per_page'=>1}))

shop_id = "8b9fbece-73fa-494d-bad5-c7fd9e52f9a0"
customer_id = "78e56df5-dd71-4554-86e5-b0eb8d3781cb"
private_money_id = "4b138a4c-8944-4f98-a5c4-96d3c1c415eb"
money_amount = 100
point_amount = 200
description = "topup test"
response = c.send(Pokepay::Request::CreateTransaction.new(
                    shop_id, customer_id, private_money_id,
                    money_amount, point_amount, description))
```

## Run test

```
$ bundle exec ruby test/pokepay_partner_ruby_sdk_test.rb
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pokepay/pokepay_partner_ruby_sdk.
