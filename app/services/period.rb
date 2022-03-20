class Period
  attr_reader :duration, :start_date, :calculator

  class NoExtraFundsError < StandardError; end

  def initialize duration:, start_date:, calculator:
    @duration = duration
    @start_date = start_date
    @calculator = calculator
  end

  def dividend_to_pay?
    calculator.dividend_to_pay?
  end

  def undistributed_funds
    calculator.available_funds
  end

  def dividend
    calculator.dividend
  end

  def dividend_date
    start_date + duration
  end

  def next_period extra_funds:
    raise NoExtraFundsError unless extra_funds.positive?

    Period.new(
      duration: duration,
      start_date: start_date + duration,
      calculator: DistributionCalculator.new(
        member_count: calculator.member_count,
        available_funds: undistributed_funds + extra_funds,
        minimum_dividend: calculator.minimum_dividend
      )
    )
  end
end
