class Member < ApplicationRecord
  include Customer, Balance, Dividend, Subscription

  validates :name, :email, presence: true
end
