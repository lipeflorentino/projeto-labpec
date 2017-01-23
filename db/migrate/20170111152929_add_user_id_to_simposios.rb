class AddUserIdToSimposios < ActiveRecord::Migration[5.0]
  def change
    add_column :simposios, :user_id, :integer
  end
end
