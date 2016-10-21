class Evento < ApplicationRecord
  validates :descricao, presence: true, length: {minimum: 20, maximum: 600000 }
end
