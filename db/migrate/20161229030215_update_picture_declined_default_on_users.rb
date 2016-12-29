class UpdatePictureDeclinedDefaultOnUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :picture_declined
    add_column :users, :picture_declined, :boolean, :default => false
  end
end
