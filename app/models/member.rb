class Member < ApplicationRecord
  include Customer, Subscription

  validates :name, :email, presence: true
end
