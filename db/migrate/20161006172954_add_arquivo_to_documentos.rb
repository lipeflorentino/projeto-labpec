class AddArquivoToDocumentos < ActiveRecord::Migration[5.0]
  def change
    add_column :documentos, :arquivo, :string
  end
end
