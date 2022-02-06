class CreateCharges < ActiveRecord::Migration[7.0]
  def change
    create_table :charges do |t|
      t.string :stripe_charge_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
