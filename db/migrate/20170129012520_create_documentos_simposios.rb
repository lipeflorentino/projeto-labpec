class CreateDocumentosSimposios < ActiveRecord::Migration[5.0]
  def change
    create_table :documentos_simposios do |t|
      t.string :arquivo
      t.integer :simposio_id

      t.timestamps
    end
  end
end
