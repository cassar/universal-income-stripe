class AddCard < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :stripe_card_id, :string 
  end
end
