class AddVezesVisitadoToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :vezes_visitado, :integer, :default => 0
  end
end
