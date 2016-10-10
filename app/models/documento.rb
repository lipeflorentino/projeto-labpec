class Documento < ApplicationRecord
  belongs_to :user
  
  mount_uploader :arquivo, FileUploader
  validate :data_nao_esta_no_passado
  validates :user_id, presence: true
  validates :descricao, presence: true, length: { minimum: 30, maximum: 180 }
  validates :titulo, presence: true, length: { minimum: 10, maximum: 120 }
  validate :tamanho_do_arquivo
  
  private
    def data_nao_esta_no_passado
      if !dafata_defesa.present?
        errors.add(:data_defesa, "O documento deve possuir uma data em que foi defendido")
        return
      end
      if data_defesa >= (Date.now + 1.day)
          errors.add(:data_defesa, "Experimente checar a data (está no futuro)")
      end
    end
    
    def tamanho_imagem
      if !arquivo
        errors.add :arquivo, 'O post deve possuir um arquivo anexado.'
        return
      end
      if arqvuio.size > (4).megabytes
        errors.add :arquivo, 'O arquivo deve conter no máximo 4 megabytes.'
      end
    end
end
