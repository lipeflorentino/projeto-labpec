class AddIndexOnVideosSimposios < ActiveRecord::Migration[5.0]
  def change
    add_index :videos_simposios, :simposio_id
  end
end
