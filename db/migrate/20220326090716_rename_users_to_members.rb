class RenameUsersToMembers < ActiveRecord::Migration[7.0]
  def change
    rename_table :users, :members
  end
end
