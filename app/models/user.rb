class User < ApplicationRecord
  include StripeCustomer, StripeBalance, Dividend

  validates :name, :email, presence: true
end
