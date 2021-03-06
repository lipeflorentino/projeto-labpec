class Simposio < ApplicationRecord
  has_many :video_simposio, dependent: :destroy
  has_many :documentos_simposio, dependent: :destroy 
  belongs_to :user
  
  # Validação 'conteudo'
  
  validates_presence_of :conteudo
  validates :conteudo, length: {minimum: 50, maximum: 50000 }, 
                       allow_blank: true
  
  # Validação 'picture'
  
  validate :tamanho_imagem
  
  # Validação 'titulo'
  
  validates_presence_of :titulo
  validates :titulo, length: { minimum: 10, maximum: 90 }, 
                     allow_blank: true
  
  # Validação 'user_id'
  
  validates_presence_of :user_id
  
  ##
  
  
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
