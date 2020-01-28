# coding: utf-8
require 'minitest/autorun'
require "pokepay_partner_ruby_sdk"
require "inifile"

$client = Pokepay::Client.new(File.expand_path("~/.pokepay/test-config.ini"))
$inifile = IniFile.load(File.expand_path("~/.pokepay/test-config.ini"))

class PokepayTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Pokepay::VERSION
  end

  def test_can_send_echo
    response = $client.send(Pokepay::Request::CreateEcho.new('hello'))
    assert_equal response.class, Pokepay::Response::Response
    assert_equal response.code, "200"
    assert_equal response.object.class, Pokepay::Response::Echo
    assert_equal response.object.message, 'hello'
  end

  def test_can_not_send_echo
    response = $client.send(Pokepay::Request::CreateEcho.new(0))
    assert_equal response.class, Net::HTTPBadRequest
    assert_equal response.code, "400"
    assert_equal response.body, {"type"=>"invalid_parameters",
                                 "message"=>"Invalid parameters",
                                 "errors"=>{"invalid"=>["message"]}}
  end

  def test_can_get_transactions
    response = $client.send(Pokepay::Request::ListTransactions.new(per_page: 1))
    assert_equal response.class, Pokepay::Response::Response
    assert_equal response.code, "200"
    assert_equal response.object.class, Pokepay::Response::PaginatedTransaction
  end

  def test_can_not_get_transactions
    response = $client.send(Pokepay::Request::ListTransactions.new(per_page: -1))
    assert_equal response.class, Net::HTTPBadRequest
    assert_equal response.code, "400"
    assert_equal response.body, {"type"=>"invalid_parameters",
                                 "message"=>"Invalid parameters",
                                 "errors"=>{"invalid"=>["per_page"]}}
  end

  def test_can_create_transaction
    shop_id = $inifile["testdata"]["shop_id"]
    customer_id = $inifile["testdata"]["customer_id"]
    private_money_id = $inifile["testdata"]["private_money_id"]
    money_amount = 100
    point_amount = 200
    description = "チャージテスト"
    response = $client.send(Pokepay::Request::CreateTransaction.new(
                              shop_id, customer_id, private_money_id,
                              money_amount: money_amount, point_amount: point_amount, description: description))
    assert_equal response.code, "200"
    assert_equal response.object.class, Pokepay::Response::Transaction
    assert_equal response.object.sender.id, shop_id
    assert_equal response.object.receiver.id, customer_id
    assert_equal response.object.receiver_account.private_money.id, private_money_id
    assert_equal response.object.sender_account.private_money.id, private_money_id
    assert_equal response.object.money_amount, money_amount
    assert_equal response.object.point_amount, point_amount
  end

  def test_can_not_create_transaction
    #shop_id = $inifile["testdata"]["shop_id"]
    customer_id = $inifile["testdata"]["customer_id"]
    private_money_id = $inifile["testdata"]["private_money_id"]
    random_id = SecureRandom.uuid
    money_amount = 100
    point_amount = 200
    description = "チャージテスト"
    response = $client.send(Pokepay::Request::CreateTransaction.new(
                              random_id, customer_id, private_money_id,
                              money_amount: money_amount, point_amount: point_amount, description: description))
    assert_equal response.code, "422"
    assert_equal response.body, {"type"=>"shop_user_not_found", "message"=>"The shop user is not found"}
  end
end
