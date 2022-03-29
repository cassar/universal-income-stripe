module Customer
  extend ActiveSupport::Concern

  class ExistingCustomerError    < StandardError; end
  class NonExistingCustomerError < StandardError; end
  class ExistingStripeCardError  < StandardError; end

  DEFAULT_CURRENCY = 'aud'
  DEFAULT_SOURCE = 'tok_amex'

  included do
    def create_stipe_customer!
      raise ExistingCustomerError if stripe_customer_id

      customer = Stripe::Customer.create({name: name, email: email})
      update stripe_customer_id: customer.id
    end

    def create_stripe_card!
      raise NonExistingCustomerError unless stripe_customer_id
      raise ExistingStripeCardError if stripe_card_id

      card = Stripe::Customer.create_source(
        stripe_customer_id,
        {
          source: DEFAULT_SOURCE
        },
      )
      update stripe_card_id: card.id
    end
  end
end
