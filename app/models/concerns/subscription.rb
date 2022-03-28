module Subscription
  extend ActiveSupport::Concern

  class TooManyStripeSubscriptionsError        < StandardError; end
  class StripeSubscriptionItemCountNotOneError < StandardError; end

  included do
    def update_or_create_subscription unit_amount:
      if (subscription = find_subscription)
        update_subscription subscription: subscription, unit_amount: unit_amount
      else
        create_subscription unit_amount: unit_amount
      end
    end

    private

    def find_subscription
      subscriptions = Stripe::Subscription.list({customer: stripe_customer_id})
      raise TooManyStripeSubscriptionsError if subscriptions.count > 1

      subscriptions.first
    end

    def update_subscription subscription:, unit_amount:
      raise StripeSubscriptionItemCountNotOneError if (items = subscription.items).count != 1

      update_subscription_item subscription_item: items.first, unit_amount: unit_amount
    end

    def update_subscription_item subscription_item:, unit_amount:
      Stripe::SubscriptionItem.update(
        subscription_item.id,
        {
          price: Price.find_or_create_by(unit_amount: unit_amount).id,
          proration_behavior: 'none',
        },
      )
    end

    def create_subscription unit_amount:
      Stripe::Subscription.create({
        customer: stripe_customer_id,
        items: [
          {price: Price.find_or_create_by(unit_amount: unit_amount)},
        ],
      })
    end
  end
end
