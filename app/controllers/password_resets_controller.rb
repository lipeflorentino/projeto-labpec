class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
  def new
  end
  
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "E-mail enviado com instruções!"
      redirect_to root_url
    else
      flash.now[:danger] = "E-mail não encontrado no sistema."
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if params[:user][:password].empty?                 
      @user.errors.add(:password, "não pode ficar em branco")
      render 'edit'
    else 
      if @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])          
        log_in @user
        flash[:success] = "Você alterou a senha com sucesso"
        redirect_to @user
      else
        render 'edit'
      end
    end
  end
  
  private
    def get_user
      emailFix = params[:email]
      # Essas linhas de comentário foram uma tentativa de fazer funcionar
      # em development mode no cloud9
      #emailFix.reverse!
      #emailFix.chop!
      #emailFix.chop!
      #emailFix.reverse!
      @user = User.find_by(email: emailFix)
    end

    # Confirms a valid user.
    def valid_user
      idFix = params[:id]
      # Essas linhas de comentário foram uma tentativa de fazer funcionar
      # em development mode no cloud9
      #aux = idFix.reverse.byteslice(0,8)
      #10.times do 
      #  idFix.chop! 
      #end
      #aux.reverse!
      #idFix << aux
      unless (@user && @user.activated? &&
              @user.reset_authenticated?(idFix))
        redirect_to users_url
      end
    end
    
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "O pedido de alteração de senha foi expirado."
        redirect_to root_url
      end
    end
    
end
