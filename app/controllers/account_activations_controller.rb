class AccountActivationsController < ApplicationController

  def edit
    # emailFix porq o email tava chegando com um "3D" na frente
    # só acontece em development
    
    emailFix = params[:email]
    emailFix.reverse!
    emailFix.chop!
    emailFix.chop!
    emailFix.reverse!
    user = User.find_by(email: params[:email])
    
    idFix = params[:id]
    aux = idFix.reverse.byteslice(0,2)
    idFix.chop!
    idFix.chop!
    idFix.chop!
    idFix.chop!
    aux.reverse!
    idFix << aux
    
    # Se entrar aqui é porq o usuário não autenticou corretamente
    #if !user.authenticated?(idFix)
    if !user.authenticated?(idFix)
      redirect_to emailFix_url
      return
    end
    
    if user && user.authenticated?(idFix)
    # Para checar se é pra ativar a conta ou é pra trocar o email 
      if !user.activated?
        user.activate
        #log_in user
        flash[:success] = "Conta ativada!"
        redirect_to root_url
        return
      else
        if !user.new_email.nil?
          user.update(:email => user.new_email, :new_email => nil)
          flash[:success] = "Email alterado com sucesso!"
          redirect_to root_url
          return
        end
        flash[:danger] = "Um erro ocorreu, tente novamente."
        redirect_to root_url
        return
      end
    else
      flash[:danger] = "Link de confirmação inválido"
      redirect_to users_url
    end
  end
end