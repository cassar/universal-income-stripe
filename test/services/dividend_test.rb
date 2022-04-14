require "test_helper"

class DividendTest < ActiveSupport::TestCase
  test ".next_dividend_amount" do
    common_dividend_stubs
    assert_equal 200, Dividend.next_dividend_amount
  end

  test ".next_dividend_date" do
    common_dividend_stubs
    assert_equal @date + 2.weeks, Dividend.next_dividend_date
  end

  def common_dividend_stubs
    @date = Date.parse("2020 Dec 4th")
    Member.stubs(:period_duration).returns(1.week).once
    Date.stubs(:today).returns(@date).once
    Member.stubs(:count).returns(3).once
    Member.stubs(:available_stripe_balance).returns(300).once
    Member.stubs(:minimum_dividend).returns(200).once
    Member.stubs(:contributions).returns(300).once
  end
end
