class User < ApplicationRecord
    has_many :post, dependent: :destroy
    has_many :documento # dependent :destroy?
    
    attr_accessor :activation_token, :email_confirmation, :actual_password, :reset_token
    
    validate :email_match_email_confirmation, on: :create
    validate :new_email_match_email_confirmation, on: :update
    
    # chamada do método pra criar a activation_digest para futura confirmação de usuario
    # ocorre somente no ato de criação
    before_create :create_activation_digest
    before_save { self.email = email.downcase }
    
    # REGEX dizendo que o email deve ter esse formato: "email@dominio.com" + qualquer coisa
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }, on: :update, allow_blank: true
    validates :new_email, length: { maximum: 255 },
                          format: { with: VALID_EMAIL_REGEX },
                          uniqueness: { case_sensitive: false }, on: :update, allow_blank: true
    validates :matricula,  numericality: { only_integer: true }, length: { minimum: 5,  maximum: 15 }
    has_secure_password # bcrypt para manter a senha segura
    validates :password, presence: true, length: { minimum: 6, maximum: 20 }, on: :create
    # deixa o usuario dar update sem botar uma senha
    validates :password, length: { minimum: 6, maximum: 20 }, on: :update, allow_blank: true
    validates :name, presence: true, length: { minimum: 5, maximum: 40 }
    mount_uploader :picture, PictureUploader
    validate :tamanho_imagem
    
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
    
    def User.new_token
      SecureRandom.urlsafe_base64
    end
    
    def create_reset_digest
      self.reset_token = User.new_token
      update_attribute(:reset_digest,  User.digest(reset_token))
      update_attribute(:reset_sent_at, Time.zone.now)
    end
    
    def send_password_reset_email
      UserMailer.password_reset(self).deliver_now
    end
  
    # Retorna true se a token combina com o digest da confirmação 
    def authenticated?(token)
      digest = self.activation_digest
      return false  if digest.nil?
      # isso pode retornanar falso
      BCrypt::Password.new(digest).is_password?(token)
    end
    
    # Retorna true se a reset_token combina com o digest da confirmação 
    def reset_authenticated?(token)
      digest = self.reset_digest
      return false  if digest.nil?
      # isso pode retornanar falso
      BCrypt::Password.new(digest).is_password?(token)
    end
    
      # Activates an account.
    def activate
      update_attribute(:activated, true)
    end
  
    # Sends activation email.
    def send_activation_email
      UserMailer.account_activation(self).deliver_now
    end
    
    def send_update_activation_email
      UserMailer.update_activation(self).deliver_now
    end
    
    def update_activation_digest
      # Cria o token e usa criptografia
      self.activation_token  = User.new_token
      update_attribute(:activation_digest, User.digest(activation_token))
    end
    
    def password_reset_expired?
      reset_sent_at < 2.hours.ago
    end
  
    def foto_para_aprovar?
      if picture? and picture_accepted == false
        return true
      end
    end
  
  private 
  
    def tamanho_imagem
      if picture.size > (5/2).megabytes
        errors.add :picture, 'Imagem não pode ser maior que 2.5 Megabytes'
      end
    end
  
    def email_match_email_confirmation
      if email && email_confirmation
        unless email_confirmation == email 
          errors.add :email, '=> confirmação não combina'
        end
      end
    end
    
    def new_email_match_email_confirmation
      if new_email && email_confirmation
        unless email_confirmation == new_email
          errors.add :new_email, '=> confirmação não combina'
        end
        if User.find_by(:email => new_email)
          errors.add :new_email, '=> já está sendo usado'
        end
      end
    end
    
    def create_activation_digest
      # Cria o token e usa criptografia
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
    
    def aprova_foto
      if picture_accepted === false and picture != null
        picture_accepted = true
      end
    end
    
    
end
