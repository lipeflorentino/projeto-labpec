class Evento < ApplicationRecord
  validates :descricao, presence: true, length: {minimum: 20, maximum: 600000 }
  validates :data, presence: true
  
  
  # funcao auxiliar para o calendar
  def start_time
    self.data
  end
  
  
end
