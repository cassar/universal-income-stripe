require "test_helper"

class UserTest < ActiveSupport::TestCase
  include StripeCustomerTest, StripeBalanceTest, DividendTest

  setup do
    @non_stripe_customer = users(:one)
    @stripe_customer = users(:stripe_customer)
    @stripe_card_customer = users(:stripe_card_customer)
    @balanceable_class = @dividendable_class = User
  end

  test "associations" do
    assert_includes users(:stripe_card_customer).charges, charges(:one)
  end

  test "name cannot be nil" do
    error = assert_raises ActiveRecord::RecordInvalid do
      User.new(name: "", email: "rudiger@hey.com").save!
    end
    assert_equal "Validation failed: Name can't be blank", error.message
  end

  test "email cannot be blank" do
    error = assert_raises ActiveRecord::RecordInvalid do
      User.new(name: "Rudiger", email: "").save!
    end
    assert_equal "Validation failed: Email can't be blank", error.message
  end
end
