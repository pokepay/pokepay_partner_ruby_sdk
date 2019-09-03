require "test_helper"
require "pokepay_partner_ruby_sdk/client"

class PokepayTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Pokepay::VERSION
  end

  def initialize_test
    @client = Pokepay::Client.new("/home/wiz/tmp/phpsdk-test/config.ini")
  end

  def test_it_does_something_useful
    assert false
  end
end
