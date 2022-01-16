class User < ApplicationRecord
  include StripeCustomer

  validates :name, :email, presence: true
end
