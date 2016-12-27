class AddAccpetedToDocumentos < ActiveRecord::Migration[5.0]
  def change
    add_column :documentos, :accepted, :boolean, :default => false
  end
end
