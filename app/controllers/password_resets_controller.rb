class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  
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
  
  private
    def get_user
      #emailFix = params[:email]
      #emailFix.reverse!
      #emailFix.chop!
      #emailFix.chop!
      #emailFix.reverse!
      @user = User.find_by(email: emailFix)
    end

    # Confirms a valid user.
    def valid_user
      idFix = params[:id]
      #aux = idFix.reverse.byteslice(0,8)
      #10.times do 
      #  idFix.chop! 
      #end
      #aux.reverse!
      #idFix << aux
      unless (@user && @user.activated? &&
              !@user.authenticated?(idFix))
        redirect_to users_url
      end
    end
    
end
