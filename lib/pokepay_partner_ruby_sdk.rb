# encoding: utf-8

require "pokepay_partner_ruby_sdk/version"
require "pokepay_partner_ruby_sdk/crypto"
require "pokepay_partner_ruby_sdk/client"
require "pokepay_partner_ruby_sdk/request/request"
require "pokepay_partner_ruby_sdk/request/send_echo"

module Pokepay
  class Error < StandardError; end
  # Your code goes here...
end

# c = Pokepay::Client.new("/home/wiz/tmp/phpsdk-test/config.ini")
# response = c.post("/echo", {"message" => "hello"})
# c.decode(response)

# response = c.get("/transactions", {"per_page" => 1})
# c.decode(response)


# res = c.send(Pokepay::Request::SendEcho.new('hello'))
