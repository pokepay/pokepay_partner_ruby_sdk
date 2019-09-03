$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "pokepay_partner_ruby_sdk"

require "minitest/autorun"

$client = Pokepay::Client.new(File.expand_path("~/.pokepay/config.ini"))
