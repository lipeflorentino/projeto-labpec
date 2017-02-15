class PagesController < ApplicationController
  
   # Verifica se o usuario está logado
  before_action :authenticated_as_user, :only => [:aprovacao_imagens]
  # Verifica se é adm
  before_action :authenticated_as_admin, :only => [:aprovacao_imagens]
    
    def arquivos
      @datas_min = Array.new
      ultima_data = Post.last.created_at
      @datas_min << ultima_data
      @data_freq = Array.new
      @data_freq << 0 if ultima_data != nil
      Post.order('created_at DESC').each do |p|
        if p.created_at.month != ultima_data.month
          @datas_min << p.created_at
          @data_freq << 1
          ultima_data = p.created_at
        else 
          @data_freq[(@datas_min.length) -1] += 1
        end
      end
    end
    
    def home
      @noticias = Post.last(3)
      @eventos = Evento.order(:data).last(3)
    end    
    
    def linhasDePesquisa
    end  
    
    def arquivo_show
      data = params[:data]
      @data_ini = DateTime.new(params[:year].to_i, params[:month].to_i, 01)
      data_fim = DateTime.new(params[:year].to_i, params[:month].to_i + 1, 01) - 1.minute
      @posts = Post.where(created_at: @data_ini..data_fim)
    end
    
    def publicacoes
      
        # Cria array de meses
        @datas_min = Array.new
        # pega o ultimo post
        ultima_data = Post.last.created_at
        # Bota o ultimo post na array
        @datas_min << ultima_data
        # Cria array com o número de posts referentes a cada mes
        @data_freq = Array.new
        # Bota 0 caso tenha ultimo post (gambiarra)
        @data_freq << 0 if ultima_data != nil
        # itera array de posts com criação decrescente
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
            @posts = Post.reorder("created_at DESC").page(params[:page]).per_page(5)    
        end
    end 
    
    def simposios
      
        @datas_min = Array.new
        ultima_data = Post.last.created_at
        @datas_min << ultima_data
        @data_freq = Array.new
        @data_freq << 0 if ultima_data != nil
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
            @posts = Post.reorder("created_at DESC").page(params[:page]).per_page(5)    
        end
    end
    
    def eventos
      @proximo_evento = Evento.order(:data).last
      @eventos_semana = Evento.all
      if params[:evento]
          # busca
            @eventos = Evento.reorder("created_at DESC").where('titulo LIKE ? or descricao LIKE ?', 
                                    "%#{params[:evento][:search]}%", "%#{params[:evento][:search]}%").page(params[:page]).per_page(4)
        else
            # Ordena invertido pra aparecer os mais recentes primeiro, sem parametro de busca
            @eventos = Evento.reorder("created_at DESC").page(params[:page]).per_page(5)    
        end
    end  
    
    def parceiros
    end  
    
    def teses
        @datas_min = Array.new
        ultima_data = Documento.last.created_at
        @datas_min << ultima_data
        @data_freq = Array.new
        @data_freq << 0 if ultima_data != nil
        Documento.order('created_at DESC').each do |p|
          if p.created_at.month != ultima_data.month
            @datas_min << p.created_at
            @data_freq << 1
            ultima_data = p.created_at
          else 
            @data_freq[(@datas_min.length) -1] += 1
          end
        end
        # entra no if se tiver parametro de busca, ordenando pelo mais visitado
        if params[:tese]
            # o operador " | " aqui junta as duas buscas em uma só removendo duplicatas
            @teses = Documento.reorder("created_at DESC").where('titulo LIKE ? or descricao LIKE ? and accepted=true', 
                                    "%#{params[:tese][:search]}%", "%#{params[:tese][:search]}%").page(params[:page]).per_page(4)
        else
            # Ordena invertido pra aparecer os mais recentes primeiro, sem parametro de busca
            @teses = Documento.reorder("created_at DESC").where("accepted = ?", true).page(params[:page]).per_page(6)    
        end
    end
    
    def recuperacao
    end
    
    def aprovacao_imagens
      # Pega só os usuários que precisam de aprovação na imagem
      @users = User.where("picture_accepted = ? and picture_declined = ?", false, false)
    end
    
    
    
    
end