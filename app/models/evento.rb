class Evento < ApplicationRecord
  belongs_to :user
  
  # Validação 'titulo'
  
  validates_presence_of :titulo
  validates :titulo, length: { minimum: 10, maximum: 90 }, 
                     allow_blank: true
  
  # Validação 'descricao'
  
  validates_presence_of :descricao
  validates :descricao, length: {minimum: 20, maximum: 250 }, 
                        allow_blank: true
  
  # Validação 'data'
  
  validates_presence_of :data
  
  # Validação 'localização'
  
  validates_presence_of :localizacao
  
  # Função auxiliar para o calendar
  def start_time
    self.data
  end
  
  
end
