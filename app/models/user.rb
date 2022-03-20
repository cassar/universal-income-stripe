class User < ApplicationRecord
  include StripeCustomer, StripeBalance, Dividend

  has_many :charges

  validates :name, :email, presence: true
end
