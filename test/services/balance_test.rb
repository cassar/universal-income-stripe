require "test_helper"

class BalanceTest < ActiveSupport::TestCase
  test ".available_stripe_balance" do
    Stripe::Balance.stubs(:retrieve).returns(Stripe::Balance.new)
    stripe_object = Stripe::StripeObject.new
    stripe_object.currency = "aud"
    stripe_object.amount = 5000
    Stripe::Balance.any_instance.stubs(:available).returns([stripe_object])

    assert_equal 5000, Balance.available_stripe_balance
  end

  test ".pending_stripe_balance" do
    Stripe::Balance.stubs(:retrieve).returns(Stripe::Balance.new)
    stripe_object = Stripe::StripeObject.new
    stripe_object.currency = "aud"
    stripe_object.amount = 2000
    Stripe::Balance.any_instance.stubs(:pending).returns([stripe_object])

    assert_equal 2000, Balance.pending_stripe_balance
  end
end
