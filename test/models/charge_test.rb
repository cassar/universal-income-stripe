require "test_helper"

class ChargeTest < ActiveSupport::TestCase
  test "associations" do
    assert_equal users(:stripe_card_customer), charges(:one).user
  end

  test "#stripe_card_id to nil" do
    error = assert_raises ActiveRecord::RecordInvalid do
      charges(:one).update! stripe_charge_id: nil
    end
    assert_equal "Validation failed: Stripe charge can't be blank", error.message
  end
end
