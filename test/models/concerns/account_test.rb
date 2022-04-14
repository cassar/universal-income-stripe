module AccountTest
  extend ActiveSupport::Concern

  included do
    test "#stripe_account_id" do
      assert_respond_to @stripe_account, :stripe_account_id
      assert_respond_to @non_stripe, :stripe_account_id
    end

    test "#create_stipe_account! with existing stripe account" do
      assert_raises Account::ExistingAccountError do
        @stripe_account.create_stripe_account!
      end
    end

    test "#create_stipe_account! with new stripe account" do
      Stripe::Account.stubs(:create)
        .with({type: Account::DEFAULT_TYPE, email: @non_stripe.email})
        .returns(Stripe::Account.new(id: new_account_id = "new account id"))
        .once

      @non_stripe.create_stripe_account!

      assert_equal new_account_id, @non_stripe.stripe_account_id
    end
  end
end
