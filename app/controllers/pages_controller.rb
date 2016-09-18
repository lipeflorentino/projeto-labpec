class PagesController < ApplicationController
    
    
    def Home
    end    
    
    def LinhasDePesquisa
    end  
    
    def publicacoes
        #@posts = Post.paginate(:order => 'created_at DESC', :page => params[:page], :per_page =>3, :conditions => ['descricao like ?', "%#{params[:search]}%"]) 
        # Ordena invertido
        if params[:post]
            @posts = Post.reorder("created_at DESC").where('titulo LIKE ?', "%#{params[:post][:search]}%").page(params[:page]).per_page(4)    
        else
            @posts = Post.reorder("created_at DESC").where('titulo LIKE ?', "%#{params[:search]}%").page(params[:page]).per_page(4)    
        end
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