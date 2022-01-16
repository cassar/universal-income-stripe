module StripeCustomerTest
  extend ActiveSupport::Concern

  included do
    test "#create_stripe_customer saves a stripe_customer_id" do
      Stripe::Customer.stubs(:create)
        .returns(Stripe::Customer.new(id: new_customer_id = "new customer id"))
        .once

      @non_stripe_customer.create_stipe_customer

      assert_equal new_customer_id, @non_stripe_customer.stripe_customer_id
    end

    test "#create_stipe_customer fails if stripe_customer_id already present" do
      assert_raises StripeCustomer::ExistingStripeCustomerError do
        @existing_stripe_customer.create_stipe_customer
      end
    end
  end
end
