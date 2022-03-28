class Member < ApplicationRecord
  include Customer, StripeBalance, Dividend, Subscription

  validates :name, :email, presence: true
end
