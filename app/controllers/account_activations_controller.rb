class AccountActivationsController < ApplicationController

  def edit
    # emailFix porq o email tava chegando com um "3D" na frente
    # emailFix = params[:email]
    # emailFix.reverse!
    # emailFix.chop!
    # emailFix.chop!
    # emailFix.reverse!
    user = User.find_by(email: params[:email])
    
    #idFix = params[:id]
    #aux = idFix.reverse.byteslice(0,2)
    #idFix.chop!
    #idFix.chop!
    #idFix.chop!
    #idFix.chop!
    #aux.reverse!
    #idFix << aux
    
    if !user.authenticated?(params[:id])
      redirect_to emailFix_url
      return;
    end
    if user && !user.activated? && user.authenticated?(params[:id])
      user.activate
      #log_in user
      flash[:success] = "Account activated!"
      redirect_to root_url
    else
      flash[:danger] = "Invalid activation link"
      redirect_to users_url
    end
  end
end