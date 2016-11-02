class AddPictureAcceptedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :picture_accepted, :boolean, default: false
  end
end
