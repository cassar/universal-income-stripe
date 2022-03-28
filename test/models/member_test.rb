require "test_helper"

class MemberTest < ActiveSupport::TestCase
  include StripeCustomerTest, StripeBalanceTest, DividendTest, SubscriptionTest

  setup do
    @non_stripe_customer = members(:one)
    @stripe_customer = members(:stripe_customer)
    @stripe_card_customer = members(:stripe_card_customer)
    @balanceable_class = @dividendable_class = Member
  end

  test "name cannot be nil" do
    error = assert_raises ActiveRecord::RecordInvalid do
      Member.new(name: "", email: "rudiger@hey.com").save!
    end
    assert_equal "Validation failed: Name can't be blank", error.message
  end

  test "email cannot be blank" do
    error = assert_raises ActiveRecord::RecordInvalid do
      Member.new(name: "Rudiger", email: "").save!
    end
    assert_equal "Validation failed: Email can't be blank", error.message
  end
end
