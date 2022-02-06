require "test_helper"

class UserTest < ActiveSupport::TestCase
  include StripeCustomerTest

  setup do
    @non_stripe_customer = users(:one)
    @existing_stripe_customer = users(:existing_stripe_customer)
    @stripe_card_customer = users(:stripe_card_customer)
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
