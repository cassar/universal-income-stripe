class AddStripeAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :members, :stripe_account_id, :string
  end
end
