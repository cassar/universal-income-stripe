class User < ApplicationRecord
  include StripeCustomer, StripeBalance

  has_many :charges

  validates :name, :email, presence: true
end
