module Dividend
  extend ActiveSupport::Concern

  class_methods do
    def next_dividend_amount
      next_paying_period.dividend
    end

    def next_dividend_date
      next_paying_period.dividend_date
    end

    def period_duration
      1.week
    end

    def minimum_dividend
      100
    end

    def periodic_contributions
      300
    end

    private

    def next_paying_period
      periods.find(&:dividend_to_pay?)
    end

    def periods
      periods = [first_period]
      loop do
        return periods if (last_period = periods.last).dividend_to_pay?

        periods << last_period.next_period(
          extra_funds: User.periodic_contributions
        )
      end
    end

    def first_period
      Period.new(
        duration: User.period_duration,
        start_date: Date.today,
        calculator: DistributionCalculator.new(
          member_count: User.count,
          available_funds: User.available_stripe_balance,
          minimum_dividend: User.minimum_dividend
        )
      )
    end
  end
end
