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
    
    # Validação 'nome'
    
    validates_presence_of :name
    validates :name, length: { minimum: 5, maximum: 40 }, 
                     allow_blank: true
    
    # Validação 'email' (retirei on update)
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates_presence_of :email
    validates :email, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }, 
                      allow_blank: true
    
    # Validação 'new_email' (retirei on update)
    
    validates :new_email, length: { maximum: 255 },
                          format: { with: VALID_EMAIL_REGEX },
                          uniqueness: { case_sensitive: false }, 
                          allow_blank: true
    
    # Validação 'matricula'
    
    validates_presence_of :matricula
    validates :matricula,  numericality: { only_integer: true }, 
                           length: { minimum: 5,  maximum: 15 },
                           allow_blank: true
    
    # Validação 'picture'
    
    validate :tamanho_imagem
    
    # Validação 'password'
    
      # Senha do tipo (deve conter letras e numeros, minimo 8, maximo 40)
    VALID_PASSWORD_REGEX = /(?=.*[a-zA-Z])(?=.*[0-9]).{8,40}/
    
    validates_presence_of :password, on: :create
    has_secure_password # bcrypt para manter a senha segura
    validates :password, format: { with: VALID_PASSWORD_REGEX, message: " deve possuir 8 caracteres, sendo pelo menos um numero e uma letra" },
                                 allow_blank: true
                         
  
    ##
    
    mount_uploader :picture, PictureUploader
    
    
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
