class Member < ApplicationRecord
  include StripeCustomer, StripeBalance, Dividend, Subscription

  validates :name, :email, presence: true
end
