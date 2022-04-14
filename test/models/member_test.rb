require "test_helper"

class MemberTest < ActiveSupport::TestCase
  include CustomerTest, SubscriptionTest

  setup do
    @non_stripe = members(:one)
    @stripe_customer = members(:stripe_customer)
    @stripe_card_customer = members(:stripe_card_customer)
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
