class AddIndexOnDocumentosSimposios < ActiveRecord::Migration[5.0]
  def change
    add_index :documentos_simposios, :simposio_id
  end
end
