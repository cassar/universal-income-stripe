class Member < ApplicationRecord
  include Customer, Subscription, Account

  validates :name, :email, presence: true
end
