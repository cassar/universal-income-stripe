module SubscriptionTest
  extend ActiveSupport::Concern

  included do
    PretendSubscription = Struct.new(:items)
    PretendItem = Struct.new(:id)
    PretendPrice = Struct.new(:id)

    setup do
      @pretend_price = PretendPrice.new(1)
      @pretend_price = PretendItem.new(1)
    end

    test '#update_or_create_subscription with existing subscriptons' do
      Stripe::Subscription.stubs(:list).returns([1,2]).once

      assert_raises Subscription::TooManyStripeSubscriptionsError do
        @stripe_card_customer.update_or_create_subscription unit_amount: 3000
      end
    end

    test '#update_or_create_subscription with existing items' do
      pretend_subscription = PretendSubscription.new([1,2])
      Stripe::Subscription.stubs(:list).returns([pretend_subscription]).once

      assert_raises Subscription::StripeSubscriptionItemCountNotOneError do
        @stripe_card_customer.update_or_create_subscription unit_amount: 3000
      end
    end

    test '#update_or_create_subscription with existing item' do
      pretend_subscription = PretendSubscription.new([@pretend_price])
      Stripe::Subscription.stubs(:list).returns([pretend_subscription]).once
      Stripe::SubscriptionItem.stubs(:update).returns(@pretend_price).once
      Price.stubs(:find_or_create_by).returns(@pretend_price).once

      assert_equal @pretend_price,
        @stripe_card_customer.update_or_create_subscription(unit_amount: 3000)
    end

    test '#update_or_create_subscription without existing subscription' do
      Stripe::Subscription.stubs(:list).returns([]).once
      Stripe::Subscription.stubs(:create).returns(@pretend_price)
      Price.stubs(:find_or_create_by).returns(@pretend_price).once

      assert_equal @pretend_price,
        @stripe_card_customer.update_or_create_subscription(unit_amount: 3000)
    end
  end
end
