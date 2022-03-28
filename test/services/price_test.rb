require "test_helper"

class PriceTest < ActiveSupport::TestCase
  PretendPrice = Struct.new(:unit_amount)

  setup do
    @unit_amount = 3000
    @pretend_price = PretendPrice.new(@unit_amount)
  end

  test '.find_or_create_by with existing price' do
    Product.stubs(:id).returns("stripe_product_id").once
    Stripe::Price.stubs(:list)
      .returns([@pretend_price]).once

    assert_equal @pretend_price, Price.find_or_create_by(unit_amount: @unit_amount)
  end

  test '.find_or_create_by without existing price' do
    Product.stubs(:id).returns("stripe_product_id").twice
    Stripe::Price.stubs(:list).returns([]).once
    Stripe::Price.stubs(:create)
      .returns(@pretend_price).once

    assert_equal @pretend_price, Price.find_or_create_by(unit_amount: @unit_amount)
  end
end
