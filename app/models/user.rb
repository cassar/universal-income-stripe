class User < ApplicationRecord
  include StripeCustomer

  has_many :charges

  validates :name, :email, presence: true
end
