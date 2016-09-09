class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        redirect_to user
      else
        flash.now[:notice] = 'Favor confirmar seu e-mail'
        render 'new'
      end
    else
      flash.now[:danger] = 'Email/senha inválidos'
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
  
end
