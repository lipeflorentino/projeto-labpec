class CreateSimposios < ActiveRecord::Migration[5.0]
  def change
    create_table :simposios do |t|
      t.text :conteudo
      t.string :picture
      t.string :titulo
      t.text :video

      t.timestamps
    end
  end
end
