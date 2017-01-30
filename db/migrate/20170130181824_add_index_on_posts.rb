class AddIndexOnPosts < ActiveRecord::Migration[5.0]
  def change
    add_index :posts, :user_id
  end
end
