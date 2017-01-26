class SimposiosController < ApplicationController
  before_action :set_simposio, only: [:show, :edit, :update, :destroy]
  # Verifica se o usuario está logado
  before_action :authenticated_as_user, :except => [:show, :index]
  # Verifica se é adm
  before_action :authenticated_as_admin, :except => [:show, :index]

  # GET /simposios
  # GET /simposios.json
  def index
    @simposios = Simposio.all
  end

  # GET /simposios/1
  # GET /simposios/1.json
  def show
  end

  # GET /simposios/new
  def new
    @simposio = Simposio.new
  end

  # GET /simposios/1/edit
  def edit
  end

  # POST /simposios
  # POST /simposios.json
  def create
   params[:simposio][:user_id] = current_user.id
   
   @simposio = Simposio.new(simposio_params)

    respond_to do |format|
      if @simposio.save
        
        @videosimposios = VideosSimposio.new(:simposio_id => @simposio.id)
        
        if @videosimposios.save
          format.html { redirect_to edit_videos_simposio_path(@videosimposios), notice: 'Simposio was successfully created.' }
          format.json { render :show, status: :created, location: @simposio }
        else
          format.html { render :new }
          format.json { render json: @videosimposios.errors, status: :unprocessable_entity }
        end
        
      else
        format.html { render :new }
        format.json { render json: @simposio.errors, status: :unprocessable_entity }
      end
      
    end
    
  end

  # PATCH/PUT /simposios/1
  # PATCH/PUT /simposios/1.json
  def update
    respond_to do |format|
      if @simposio.update(simposio_params)
        format.html { redirect_to @simposio, notice: 'Simposio was successfully updated.' }
        format.json { render :show, status: :ok, location: @simposio }
      else
        format.html { render :edit }
        format.json { render json: @simposio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /simposios/1
  # DELETE /simposios/1.json
  def destroy
    @simposio.destroy
    respond_to do |format|
      format.html { redirect_to simposios_url, notice: 'Simposio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_simposio
      @simposio = Simposio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def simposio_params
      params.require(:simposio).permit(:conteudo, :picture, :titulo, :video, :user_id)
    end
end
