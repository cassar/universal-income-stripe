module StripeCustomerTest
  extend ActiveSupport::Concern

  included do
    test "#stripe_customer_id" do
      assert_respond_to @non_stripe_customer, :stripe_customer_id
      assert_respond_to @stripe_customer, :stripe_customer_id
      assert_respond_to @stripe_card_customer, :stripe_customer_id
    end

    test "#stripe_card_id" do
      assert_respond_to @non_stripe_customer, :stripe_card_id
      assert_respond_to @stripe_customer, :stripe_card_id
      assert_respond_to @stripe_card_customer, :stripe_card_id
    end

    test "#create_stipe_customer! with existing stripe customer" do
      assert_raises StripeCustomer::ExistingStripeCustomerError do
        @stripe_customer.create_stipe_customer!
      end
    end

    test "#create_stipe_customer! with new stripe customer" do
      Stripe::Customer.stubs(:create)
        .with({name: @non_stripe_customer.name, email: @non_stripe_customer.email})
        .returns(Stripe::Customer.new(id: new_customer_id = "new customer id"))
        .once

      @non_stripe_customer.create_stipe_customer!

      assert_equal new_customer_id, @non_stripe_customer.stripe_customer_id
    end

    test "#create_stripe_card! with new stripe customer" do
      assert_raises StripeCustomer::NonExistingStripeCustomerError do
        @non_stripe_customer.create_stripe_card!
      end
    end

    test '#create_stripe_card! with existing stripe card' do
      assert_raises StripeCustomer::ExistingStripeCardError do
        @stripe_card_customer.create_stripe_card!
      end
    end

    test "#create_stripe_card! with existing stripe customer" do
      stripe_card_id = "stripe card id"
      Stripe::Customer.stubs(:create_source)
        .with(
          @stripe_customer.stripe_customer_id,
          {
            source: StripeCustomer::DEFAULT_SOURCE,
          }
        )
        .returns(Stripe::Card.new(id: stripe_card_id))
        .once

      @stripe_customer.create_stripe_card!

      assert_equal stripe_card_id, @stripe_customer.stripe_card_id
    end
  end
end
