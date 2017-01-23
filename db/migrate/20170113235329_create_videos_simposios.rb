class CreateVideosSimposios < ActiveRecord::Migration[5.0]
  def change
    create_table :videos_simposios do |t|
      t.integer :simposio_id
      t.string :video

      t.timestamps
    end
  end
end
