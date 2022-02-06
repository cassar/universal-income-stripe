require "test_helper"

class ChargeTest < ActiveSupport::TestCase
  test "associations" do
    assert_equal users(:stripe_card_customer), charges(:one).user
  end
end
