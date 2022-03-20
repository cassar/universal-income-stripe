require "test_helper"

class PeriodTest < ActiveSupport::TestCase
  test "dividend_to_pay?" do
    Period.new(
      duration: 1.week,
      start_date: Date.parse("2020 Dec 4th"),
      calculator: AlwaysDividend.new
    ).dividend_to_pay?
  end

  test "undistributed_funds" do
    assert_equal 500, Period.new(
      duration: 1.week,
      start_date: Date.parse("2020 Dec 4th"),
      calculator: AlwaysUndistributedFunds.new
    ).undistributed_funds
  end

  test "dividend" do
    assert_equal 100, Period.new(
      duration: 1.week,
      start_date: Date.parse("2020 Dec 4th"),
      calculator: AlwaysDividend.new
    ).dividend
  end

  test "dividend_date is end of the period" do
    date = Date.parse("2020 Dec 4th")
    assert_equal (date + 1.week), Period.new(
      duration: 1.week,
      start_date: date,
      calculator: AlwaysDividend.new
    ).dividend_date
  end

  test "next_period" do
    date = Date.parse("2020 Dec 4th")
    next_period =  Period.new(
      duration: 1.week,
      start_date: date,
      calculator: AlwaysUndistributedFunds.new
    ).next_period(extra_funds: 200)

    assert_equal 1.week, next_period.duration
    assert_equal date + 1.week, next_period.start_date
    assert_equal 700, next_period.undistributed_funds
  end

  class AlwaysDividend
    def dividend_to_pay?
      true
    end

    def dividend
      100
    end
  end

  class AlwaysUndistributedFunds
    def available_funds
      500
    end

    def member_count
      10
    end

    def minimum_dividend
      100
    end
  end
end
