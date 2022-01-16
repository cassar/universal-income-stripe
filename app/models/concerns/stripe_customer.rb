module StripeCustomer
  extend ActiveSupport::Concern

  class ExistingStripeCustomerError < StandardError; end

  included do
    def create_stipe_customer
      raise ExistingStripeCustomerError if stripe_customer_id

      customer = Stripe::Customer.create
      update stripe_customer_id: customer.id
    end
  end
end
