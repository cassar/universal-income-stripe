module DividendTest
  extend ActiveSupport::Concern

  included do
    test ".next_dividend_amount" do
      common_dividend_stubs
      assert_equal 200, @dividendable_class.next_dividend_amount
    end

    test ".next_dividend_date" do
      common_dividend_stubs
      assert_equal @date + 2.weeks, @dividendable_class.next_dividend_date
    end

    def common_dividend_stubs
      @date = Date.parse("2020 Dec 4th")
      User.stubs(:period_duration).returns(1.week).once
      Date.stubs(:today).returns(@date).once
      User.stubs(:count).returns(3).once
      User.stubs(:available_stripe_balance).returns(300).once
      User.stubs(:minimum_dividend).returns(200).once
      User.stubs(:periodic_contributions).returns(300).once
    end
  end
end
