require "test_helper"

class DistributionTest < ActiveSupport::TestCase
  test "#dividend_to_pay? when dividend is greater than the minimum dividend" do
    assert Distribution.new(
      available_funds: 6,
      minimum_dividend: 5,
      member_count: 1,
    ).dividend_to_pay?
  end

  test "#dividend_to_pay? when dividend is equal to the minimum dividend" do
    assert Distribution.new(
      available_funds: 5,
      minimum_dividend: 5,
      member_count: 1,
    ).dividend_to_pay?
  end

  test "#dividend_to_pay? when dividend is less than than minimum dividend" do
    assert_not Distribution.new(
      available_funds: 4,
      minimum_dividend: 5,
      member_count: 1,
    ).dividend_to_pay?
  end

  test "#dividend when there is a dividend to pay" do
    calculator = Distribution.new(
      available_funds: 10,
      minimum_dividend: 5,
      member_count: 2,
    )

    assert calculator.dividend_to_pay?
    assert_equal 5, calculator.dividend
  end
end
