class PagesController < ApplicationController
    
    
    def Home
    end    
    
    def LinhasDePesquisa
    end  
    
    def publicacoes
        #@posts = Post.paginate(:page => params[:page], :per_page => 3)
        # Ordena invertido 
        @posts = Post.reorder("created_at DESC").page(params[:page]).per_page(3)    
    end  
    
    def Eventos
    end  
    
    def Parceiros
    end  
    
    def Teses
    end
    
    def recuperacao
    end
    
    
end