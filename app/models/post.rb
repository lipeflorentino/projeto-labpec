class Post < ApplicationRecord

  belongs_to :user
  
  mount_uploader :picture, PictureUploader
  
  # Validação 'titulo'
  
  validates_presence_of :titulo
  validates :titulo, length: { minimum: 10, maximum: 90 }, 
                     allow_blank: true
  
  # Validação 'descricao'
  
  validates_presence_of :descricao
  validates :descricao, length: {minimum: 20, maximum: 250 }, 
                        allow_blank: true
  
  # Validação 'picture'
  
  validate :tamanho_imagem
  
  # Validação 'conteudo'
  
  validates_presence_of :conteudo
  validates :conteudo, length: {minimum: 50, maximum: 50000 }, 
                       allow_blank: true
  
  # Validação 'vezes_visitado'
  
  # Validação 'user_id'
 
  
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
