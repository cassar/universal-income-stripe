require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test '.id when no stripe_product_id environment variable set' do
    assert_raises Product::NoStripeProductIDError do
      Product.id
    end
  end

  test '.id when stripe_product_id environment variable set' do
    ENV['stripe_product_id'] = '57_stripe_product_id_a73'
    assert_equal ENV['stripe_product_id'], Product.id
  end
end
