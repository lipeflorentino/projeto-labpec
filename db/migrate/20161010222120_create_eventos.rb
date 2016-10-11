class CreateEventos < ActiveRecord::Migration[5.0]
  def change
    create_table :eventos do |t|
      t.string :titulo
      t.datetime :data
      t.text :localizacao
      t.text :descricao

      t.timestamps
    end
  end
end
