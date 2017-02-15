class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # Verifica se o usuario esta logado
  def authenticated_as_user
    if !logged_in?
      flash.now[:error] = "Você precisa estar logado para acessar essa pagina"
      redirect_to login_url
    end
  end
   
  # Verifica se o usuario logado é admin
  def authenticated_as_admin
    if !current_user.adm
      flash.now[:error] = "Você não possui permissão para acessar essa pagina. Entre em contato com o administrador do dominio."
      redirect_to root_url
    end
  end
  
  
  
end
