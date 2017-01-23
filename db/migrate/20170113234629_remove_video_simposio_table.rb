class RemoveVideoSimposioTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :videos_simposios
  end
end
