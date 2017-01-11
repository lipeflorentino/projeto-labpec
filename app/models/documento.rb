class Documento < ApplicationRecord
  belongs_to :user
  
  mount_uploader :arquivo, FileUploader
  validates_presence_of :arquivo
  validate :data_nao_esta_no_passado
  validates :user_id, presence: true
  validates :descricao, presence: true, length: { minimum: 30, maximum: 180 }
  validates :titulo, presence: true, length: { minimum: 10, maximum: 120 }
  validate :tamanho_do_arquivo
  
  def self.destroy_docs_antigos_reprovados
    Documento.where('updated_at < ? and respondido = ? and accepted = ?', Time.now - 4.weeks , true, false).destroy_all
  end
  
  private
    def data_nao_esta_no_passado
      if !data_defesa.present?
        errors.add(:data_defesa, "O documento deve possuir uma data em que foi defendido")
        return
      end
      if data_defesa >= (Date.today + 1.day)
          errors.add(:data_defesa, "Experimente checar a data (está no futuro)")
      end
    end
    
    def tamanho_do_arquivo
      if arquivo.size > (3).megabytes
        errors.add :arquivo, 'O arquivo deve conter no máximo 3 megabytes.'
      end
    end
end
