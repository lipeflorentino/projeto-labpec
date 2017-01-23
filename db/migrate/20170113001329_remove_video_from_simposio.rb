class RemoveVideoFromSimposio < ActiveRecord::Migration[5.0]
  def change
    remove_column :simposios, :video
  end
end
