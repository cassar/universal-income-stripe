module StripeCustomer
  extend ActiveSupport::Concern

  class ExistingStripeCustomerError    < StandardError; end
  class NonExistingStripeCustomerError < StandardError; end

  DEFAULT_CURRENCY = 'aud'

  included do
    def create_stipe_customer
      raise ExistingStripeCustomerError if stripe_customer_id

      customer = Stripe::Customer.create({name: name, email: email})
      update stripe_customer_id: customer.id
    end

    def charge_stripe_customer(amount:)
      raise NonExistingStripeCustomerError unless stripe_customer_id

      Stripe::Charge.create({
        amount: amount,
        currency: DEFAULT_CURRENCY,
        customer: stripe_customer_id
      })
    end
  end
end
