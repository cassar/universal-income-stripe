class Product
  class NoStripeProductIDError < StandardError; end

  def self.id
    raise NoStripeProductIDError if (stripe_product_id = ENV["stripe_product_id"]).nil?

    stripe_product_id
  end
end
