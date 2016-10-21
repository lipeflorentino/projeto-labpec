class CreateEventos < ActiveRecord::Migration[5.0]
  def change
    drop_table :eventos
    create_table :eventos do |t|
      t.string :titulo
      t.text :descricao
      t.datetime :data
      t.text :localizacao

      t.timestamps
    end
  end
end
