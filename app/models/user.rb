class User < ApplicationRecord
    belongs_to :type
    
    
    before_save { self.email = email.downcase }
    # chamada do método pra criar a activation_digest para futura confirmação de usuario
    # ocorre somente no ato de criação
    before_create :create_activation_digest
    # REGEX dizendo que o email deve ter esse formato: "email@dominio.com" + qualquer coisa
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
    validates :matricula, presence: true,  numericality: { only_integer: true }, length: { minimum: 5,  maximum: 15 }
    has_secure_password # bcrypt para manter a senha segura
    validates :password, presence: true, length: { minimum: 6, maximum: 20 }, on: :create
    # deixa o usuario dar update sem botar uma senha
    validates :password, length: { minimum: 6, maximum: 20 }, on: :update, allow_blank: true
    validates :name, presence: true, length: { minimum: 5, maximum: 40 }
    mount_uploader :picture, PictureUploader
    
    def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
    end
    
  private 
    
    def create_activation_digest
      # Cria o token e usa criptografia
      # antes de continuar aqui, preciso ver o tutorial de remember user
    end
      
  end
    
end
