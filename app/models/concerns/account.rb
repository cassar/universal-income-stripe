module Account
  extend ActiveSupport::Concern

  class ExistingAccountError < StandardError; end

  DEFAULT_TYPE = 'standard'

  included do
    def create_stripe_account!
      raise ExistingAccountError if stripe_account_id

      account = Stripe::Account.create({
        type: DEFAULT_TYPE,
        email: email
      })
      update stripe_account_id: account.id
    end
  end
end
