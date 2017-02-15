module SessionsHelper

    def log_in(user)
      session[:user_id] = user.id
    end
    
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def logged_in?
      !current_user.nil?
    end
    
    def log_out
      session.delete(:user_id)
      @current_user = nil
    end
    
    def administrador?
      if current_user
        current_user.adm?
      end
    end
    
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
  

