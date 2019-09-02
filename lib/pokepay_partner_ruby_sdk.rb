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

# c = Pokepay::Client.new("~/.pokepay/config.ini")
# res = c.post("/echo", {"message" => "hello"})
# res.body
# => "{\"status\":\"ok\",\"message\":\"hello\"}"

# res = c.get("/transactions", {"per_page" => 1})
# res.body

# res = c.send(Pokepay::Request::SendEcho.new('hello'))
# res.body
# => "{\"status\":\"ok\",\"message\":\"hello\"}"
