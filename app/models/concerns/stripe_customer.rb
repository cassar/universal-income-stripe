module StripeCustomer
  extend ActiveSupport::Concern

  class ExistingStripeCustomerError    < StandardError; end
  class NonExistingStripeCustomerError < StandardError; end
  class ExistingStripeCardError        < StandardError; end

  DEFAULT_CURRENCY = 'aud'
  DEFAULT_SOURCE = 'tok_amex'

  included do
    def create_stipe_customer!
      raise ExistingStripeCustomerError if stripe_customer_id

      customer = Stripe::Customer.create({name: name, email: email})
      update stripe_customer_id: customer.id
    end

    def create_stripe_card
      raise NonExistingStripeCustomerError unless stripe_customer_id
      raise ExistingStripeCardError if stripe_card_id

      card = Stripe::Customer.create_source(
        stripe_customer_id,
        {
          source: DEFAULT_SOURCE
        },
      )
      update stripe_card_id: card.id
    end

    def create_stripe_charge(amount:)
      raise NonExistingStripeCustomerError unless stripe_customer_id

      Stripe::Charge.create({
        amount: amount,
        currency: DEFAULT_CURRENCY,
        customer: stripe_customer_id
      })
    end
  end
end
