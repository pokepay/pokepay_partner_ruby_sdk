# coding: utf-8
require "./test_helper"
require "pokepay_partner_ruby_sdk"

class PokepayTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Pokepay::VERSION
  end

  def test_can_send_echo
    response = $client.send(Pokepay::Request::SendEcho.new('hello'))
    assert_equal response.class, Pokepay::Response::Response
    assert_equal response.code, "200"
    assert_equal response.object.class, Pokepay::Response::Echo
    assert_equal response.object.message, 'hello'
  end

  def test_can_not_send_echo
    response = $client.send(Pokepay::Request::SendEcho.new(0))
    assert_equal response.class, Net::HTTPBadRequest
    assert_equal response.code, "400"
    assert_equal response.body, {"type"=>"invalid_parameters",
                                 "message"=>"Invalid parameters",
                                 "errors"=>{"invalid"=>["message"]}}
  end

  def test_can_get_transactions
    response = $client.send(Pokepay::Request::ListTransactions.new({"per_page" => 1}))
    assert_equal response.class, Pokepay::Response::Response
    assert_equal response.code, "200"
    assert_equal response.object.class, Pokepay::Response::Transactions
  end

  def test_can_not_get_transactions
    response = $client.send(Pokepay::Request::ListTransactions.new({"per_page" => -1}))
    assert_equal response.class, Net::HTTPBadRequest
    assert_equal response.code, "400"
    assert_equal response.body, {"type"=>"invalid_parameters",
                                 "message"=>"Invalid parameters",
                                 "errors"=>{"invalid"=>["per_page"]}}
  end

  def test_can_create_transaction
    shop_id = "8b9fbece-73fa-494d-bad5-c7fd9e52f9a0"
    customer_id = "78e56df5-dd71-4554-86e5-b0eb8d3781cb"
    private_money_id = "4b138a4c-8944-4f98-a5c4-96d3c1c415eb"
    money_amount = 100
    point_amount = 200
    description = "チャージテスト"
    response = $client.send(Pokepay::Request::CreateTransaction.new(
                              shop_id, customer_id, private_money_id,
                              money_amount, point_amount, description))
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
    shop_id = "8b9fbece-73fa-494d-bad5-c7fd9e52f9a0"
    customer_id = "78e56df5-dd71-4554-86e5-b0eb8d3781cb"
    private_money_id = "4b138a4c-8944-4f98-a5c4-96d3c1c415eb"
    random_id = SecureRandom.uuid
    money_amount = 100
    point_amount = 200
    description = "チャージテスト"
    response = $client.send(Pokepay::Request::CreateTransaction.new(
                              random_id, customer_id, private_money_id,
                              money_amount, point_amount, description))
    assert_equal response.code, "422"
  end
end
