class AddConteudoToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :conteudo, :text
  end
end
