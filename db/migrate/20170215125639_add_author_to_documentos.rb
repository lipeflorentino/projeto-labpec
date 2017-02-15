class AddAuthorToDocumentos < ActiveRecord::Migration[5.0]
  def change
    add_column :documentos, :author, :string
  end
end
