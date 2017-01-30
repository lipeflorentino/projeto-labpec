class DocumentosSimposiosController < ApplicationController
  before_action :set_documentos_simposio, only: [:show, :edit, :update, :destroy]

  # GET /documentos_simposios
  # GET /documentos_simposios.json
  def index
    @documentos_simposios = DocumentosSimposio.all
  end

  def add
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
    respond_to do |format|
      format.html { redirect_to documentos_simposios_url, notice: 'Documentos simposio was successfully destroyed.' }
      format.json { head :no_content }
    end
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
