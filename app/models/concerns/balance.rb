module Balance
  extend ActiveSupport::Concern

  class_methods do
    def available_stripe_balance
      default_amount_from(:available)
    end

    def pending_stripe_balance
      default_amount_from(:pending)
    end

    private

    def default_amount_from(fund_type)
      stripe_objects = Stripe::Balance.retrieve.send(fund_type)
      default_object = default_currency_from(stripe_objects)
      default_object.amount
    end

    def default_currency_from(stripe_objects)
      stripe_objects.find do |stripe_object|
        stripe_object.currency == Customer::DEFAULT_CURRENCY
      end
    end
  end
end
