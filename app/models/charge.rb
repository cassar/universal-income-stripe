class Charge < ApplicationRecord
  belongs_to :user

  validates :stripe_charge_id, presence: true
end
