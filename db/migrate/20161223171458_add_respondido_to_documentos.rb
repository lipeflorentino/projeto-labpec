class AddRespondidoToDocumentos < ActiveRecord::Migration[5.0]
  def change
    add_column :documentos, :respondido, :boolean, :default => false
  end
end
