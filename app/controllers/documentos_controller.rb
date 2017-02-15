class DocumentosController < ApplicationController
  before_action :set_documento, only: [:show, :edit, :update, :destroy]
  # Verifica se o usuario está logado
  before_action :authenticated_as_user, :except => [:show]
  # Verifica se é adm
  before_action :authenticated_as_admin, :except => [:show, :new, :create]

  # GET /documentos
  # GET /documentos.json
  def index
    @documentos = Documento.all
  end

  # GET /documentos/1
  # GET /documentos/1.json
  def show
  end

  # GET /documentos/new
  def new
    @documento = Documento.new
  end

  # GET /documentos/1/edit
  def edit
  end
  
  def aceitar_doc
    @documentos = Documento.where(:respondido => false)
  end

  # POST /documentos
  # POST /documentos.json
  def create
    params[:documento][:user_id] = current_user.id
    @documento = Documento.new(documento_params)
    if (params[:documento][:tese] == "Tese")
      @documento.tese = true
    else
      @documento.tese = false
    end
    
    if (params[:documento][:mestrado] == "Mestrado")
      @documento.mestrado = true
    else
      @documento.mestrado = false
    end
    
    # Força o status do documento ser pendente por motivos de segurança
    @documento.accepted = false
    @documento.respondido = false
  
    respond_to do |format|
      if @documento.save
        format.html { redirect_to @documento, notice: 'Documento was successfully created.' }
        format.json { render :show, status: :created, location: @documento }
      else
        format.html { render :new }
        format.json { render json: @documento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documentos/1
  # PATCH/PUT /documentos/1.json
  def update
    respond_to do |format|
      if @documento.update(documento_params)
        format.html { redirect_to @documento, notice: 'Documento was successfully updated.' }
        format.json { render :show, status: :ok, location: @documento }
      else
        format.html { render :edit }
        format.json { render json: @documento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documentos/1
  # DELETE /documentos/1.json
  def destroy
    @documento.destroy
    respond_to do |format|
      format.html { redirect_to documentos_url, notice: 'Documento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def aprove_doc
    choice = params[:choice]
    doc = Documento.find(params[:doc_id])
    if (choice == "1")
      doc.update(accepted: true, respondido: true)
    else
      doc.update(accepted: false, respondido: true)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_documento
      @documento = Documento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def documento_params
      params.require(:documento).permit(:user_id, :titulo, :descricao, :status, :data_defesa, :tese, :mestrado, :arquivo)
    end
    
  
  
end
