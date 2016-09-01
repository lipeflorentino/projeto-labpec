class User < ApplicationRecord
    belongs_to :type
    
    validates :name, presence: true, length: { minimum: 5, maximum: 40 }
    before_save { self.email = email.downcase }
    # REGEX dizendo que o email deve ter esse formato: "email@dominio.com" + qualquer coisa
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
    validates :matricula, presence: true,  numericality: { only_integer: true }, length: { minimum: 5,  maximum: 15 }
    has_secure_password # bcrypt para manter a senha segura
    validates :password, presence: true, length: { minimum: 6 }
    
    def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
    end
    
end
