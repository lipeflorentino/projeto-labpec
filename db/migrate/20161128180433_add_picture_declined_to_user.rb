class AddPictureDeclinedToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :picture_declined, :boolean
  end
end
