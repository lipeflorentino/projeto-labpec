class AddIndexOnSimposios < ActiveRecord::Migration[5.0]
  def change
    add_index :simposios, :user_id
  end
end
