class CreateDocumentos < ActiveRecord::Migration[5.0]
  def change
    create_table :documentos do |t|
      t.integer :user_id
      t.string :titulo
      t.text :descricao
      t.boolean :status
      t.date :data_defesa
      t.boolean :tese
      t.boolean :mestrado

      t.timestamps
    end
  end
end
