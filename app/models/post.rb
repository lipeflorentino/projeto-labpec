class Post < ApplicationRecord

  belongs_to :user
  
  mount_uploader :picture, PictureUploader
  validates :descricao, presence: true, length: { minimum: 35, maximum: 150 }
  validates :titulo, presence: true, length: { minimum: 8, maximum: 50 }
  validates :picture, presence: true
  validates :conteudo, presence: true, length: {minimum: 20, maximum: 200000 }
  validate :tamanho_imagem
  
 
  
  private 
    def tamanho_imagem
      if !picture
        errors.add :picture, 'O post deve possuir imagem de descrição.'
        return
      end
      if picture.size > (6.5/2).megabytes
        errors.add :picture, 'Imagem não pode ser maior que 2.5 Megabytes'
      end
    end
end