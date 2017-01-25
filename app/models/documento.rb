class Documento < ApplicationRecord
  belongs_to :user
  
#  validates_presence_of :cpf
#  validates_length_of :cpf, :is => 11, :allow_blank => true
#  validates_numericality_of :cpf, :allow_blank => true
#  validates_uniqueness_of :cpf, :allow_blank => true
#  validates_as_cpf :cpf, :allow_blank => true
  
  # Validação user_id
  
  validates_presence_of :user_id
  
  # Validação 'titulo'
  
  validates_presence_of :titulo
  validates :titulo, length: { minimum: 10, maximum: 90 }, 
                     allow_blank: true
  
  # Validação 'descricao'
  
  validates_presence_of :descricao
  validates :descricao, length: { minimum: 30, maximum: 250 }, 
                        allow_blank: true

  # Validação 'data_defesa'
  
   validates_presence_of :data_defesa
   validate :data_nao_esta_no_passado
  
  # Validação 'status' (checar defaults)
  
  validates_presence_of :status
  
  # Validação 'tese' (checar defaults)
  
  validates_presence_of :tese
  
  # Validação 'mestrado' (checar defaults)
  
  validates_presence_of :mestrado
  
  # Validação 'arquivo'
  
  validates_presence_of :arquivo
  validate :tamanho_do_arquivo
  
  # Validação 'accepted'
  
  validates_presence_of :accepted
  
  # Validação 'respondido'
  
  validates_presence_of :respondido
  
  ##
  
  mount_uploader :arquivo, FileUploader
  
  # Exclui documentos antigos que foram reprovados
  
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
