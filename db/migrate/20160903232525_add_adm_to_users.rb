class AddAdmToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :adm, :boolean
  end
end
