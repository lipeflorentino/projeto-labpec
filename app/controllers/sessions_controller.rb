class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        if user.adm == true
          Documento.destroy_docs_antigos_reprovados
        end
        redirect_to user
      else
        flash.now[:notice] = 'Favor confirmar seu e-mail'
        render 'new'
      end
    else
      flash.now[:danger] = ' E-mail/senha inválidos'
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
  
end
