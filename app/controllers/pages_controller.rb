class PagesController < ApplicationController
    
    
    def arquivos
      @datas_min = Array.new
      ultima_data = Post.last.created_at
      @datas_min << ultima_data
      @data_freq = Array.new
      @data_freq << 1 if ultima_data != nil
      Post.order('created_at DESC').each do |p|
        if p.created_at.month != ultima_data.month
          @datas_min << p.created_at
          @data_freq << 1
          ultima_data = p.created_at
        else 
          @data_freq[(@datas_min.length) -1] += 1
        end
      end
      # tem 1 numero a mais m data_freq, verificar se é só no ultimo
    end
    
    def home
      @noticias = Post.last(3)
    end    
    
    def linhasDePesquisa
    end  
    
    def arquivo_show
      data = params[:data]
      data_ini = DateTime.new(params[:year].to_i, params[:month].to_i, 01)
      data_fim = DateTime.new(params[:year].to_i, params[:month].to_i + 1, 01) - 1.minute
      @posts = Post.where(created_at: data_ini..data_fim)
    end
    
    def publicacoes
      
        @datas_min = Array.new
        ultima_data = Post.last.created_at
        @datas_min << ultima_data
        @data_freq = Array.new
        @data_freq << 1 if ultima_data != nil
        Post.order('created_at DESC').each do |p|
          if p.created_at.month != ultima_data.month
            @datas_min << p.created_at
            @data_freq << 1
            ultima_data = p.created_at
          else 
            @data_freq[(@datas_min.length) -1] += 1
          end
          
          # Aqui limita a quantidade da array pra só mostrar as 4 primeiras
          # opções de arquivo na pagina de publicacoes
          if @datas_min.length == 4
            break
          end
        end
        @mais_visitado = Post.order("vezes_visitado DESC").first
        # entra no if se tiver parametro de busca, ordenando pelo mais visitado
        if params[:post]
            # o operador " | " aqui junta as duas buscas em uma só removendo duplicatas
            @posts = Post.reorder("vezes_visitado DESC").where('titulo LIKE ? or descricao LIKE ?', 
                                    "%#{params[:post][:search]}%", "%#{params[:post][:search]}%").page(params[:page]).per_page(4)
            
            
        else
            # Ordena invertido pra aparecer os mais recentes primeiro, sem parametro de busca
            @posts = Post.reorder("created_at DESC").page(params[:page]).per_page(4)    
        end
    end 
    
    def eventos
    end  
    
    def parceiros
    end  
    
    def teses
    end
    
    def recuperacao
    end
    
    
end