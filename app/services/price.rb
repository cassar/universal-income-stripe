class Price
  DEFAULT_TYPE = 'recurring'
  DEFAULT_INTERVAL = 'week'

  class << self
    def find_or_create_by unit_amount:
      price = find_by_unit_amount unit_amount
      return price if price.present?

      create unit_amount: unit_amount
    end

    private

    def find_by_unit_amount unit_amount
      prices = Stripe::Price.list({
        active: true,
        currency: StripeCustomer::DEFAULT_CURRENCY,
        product: Product.id,
        type: DEFAULT_TYPE
      })

      prices.find { |price| price.unit_amount == unit_amount }
    end

    def create unit_amount:
      Stripe::Price.create({
        unit_amount: unit_amount,
        currency: StripeCustomer::DEFAULT_CURRENCY,
        recurring: {interval: DEFAULT_INTERVAL},
        product: Product.id,
      })
    end
  end
end
