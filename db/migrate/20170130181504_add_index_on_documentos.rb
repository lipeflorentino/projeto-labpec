class AddIndexOnDocumentos < ActiveRecord::Migration[5.0]
  def change
    add_index :documentos, :user_id
  end
end
