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
end
