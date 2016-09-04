class RemoveTypeIdFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :type_id
  end
end
