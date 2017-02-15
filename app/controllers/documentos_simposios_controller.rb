class DocumentosSimposiosController < ApplicationController
  before_action :set_documentos_simposio, only: [:show, :edit, :update, :destroy]
   # Verifica se o usuario está logado
  before_action :authenticated_as_user
  # Verifica se é adm
  before_action :authenticated_as_admin
  
  # GET /documentos_simposios
  # GET /documentos_simposios.json
  def index
    @documentos_simposios = DocumentosSimposio.all
  end

  def adddoc
     
     # O ID que é passado nos parametros é o id do @videos_simposios
     # vamos pegar essa ID, achar o videos_simposios relacionado, achar todos 
     # os documentos relacionados com o simposio desse video e tentar achar 1 que não
     # tenha arquivo ainda. Se for achado, da update nessse documento. Se não, cria um novo.
      
      
    # acha o video simposios relacionado
    video = VideosSimposio.find(params[:id])
    
    
    
    # itera entre todos os docs que tem o simposio_id com o mesmo id do video
    DocumentosSimposio.where("simposio_id = ?", video.simposio_id).each do |doc| 
      # se o doc n tiver arquivo
      if !doc.arquivo.url
        @documento = doc
        break
      end
    end
    
    # Se tiver achado um doc com mesmo id do video sem arquivo, atualiza com o arquivo passado  
    if @documento
        @documento.update documentos_simposio_params
    # Cria um novo caso contrário
    else 
      @documentos_simposio = DocumentosSimposio.new(documentos_simposio_params)
      @documentos_simposio.simposio_id = video.simposio_id
      @documentos_simposio.save
      
    end
    
    
      
    #if (!@videos_simposio.video)
    #  @videos_simposio.update(videos_simposio_params)
    #else
    #  new_videos_simposio = VideosSimposio.new(:video => params[:videos_simposio][:video])
    #  new_videos_simposio.simposio_id = @videos_simposio.simposio_id
    #  new_videos_simposio.save
    #end
  end

  # GET /documentos_simposios/1
  # GET /documentos_simposios/1.json
  def show
  end

  # GET /documentos_simposios/new
  def new
    @documentos_simposio = DocumentosSimposio.new
  end

  # GET /documentos_simposios/1/edit
  def edit
  end

  # POST /documentos_simposios
  # POST /documentos_simposios.json
  def create
    @documentos_simposio = DocumentosSimposio.new(documentos_simposio_params)

    respond_to do |format|
      if @documentos_simposio.save
        format.html { redirect_to @documentos_simposio, notice: 'Documentos simposio was successfully created.' }
        format.json { render :show, status: :created, location: @documentos_simposio }
      else
        format.html { render :new }
        format.json { render json: @documentos_simposio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documentos_simposios/1
  # PATCH/PUT /documentos_simposios/1.json
  def update
    respond_to do |format|
      if @documentos_simposio.update(documentos_simposio_params)
        format.html { redirect_to @documentos_simposio, notice: 'Documentos simposio was successfully updated.' }
        format.json { render :show, status: :ok, location: @documentos_simposio }
      else
        format.html { render :edit }
        format.json { render json: @documentos_simposio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documentos_simposios/1
  # DELETE /documentos_simposios/1.json
  def destroy
    @documentos_simposio.destroy
    #respond_to do |format|
    #  format.html { redirect_to documentos_simposios_url, notice: 'Documentos simposio was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_documentos_simposio
      @documentos_simposio = DocumentosSimposio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def documentos_simposio_params
      params.require(:documentos_simposio).permit(:arquivo, :simposio_id)
    end
end
