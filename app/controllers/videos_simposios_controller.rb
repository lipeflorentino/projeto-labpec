class VideosSimposiosController < ApplicationController
  before_action :set_videos_simposio, only:  [:edit, :update, :destroy]
    # Verifica se o usuario está logado
  before_action :authenticated_as_user
  # Verifica se é adm
  before_action :authenticated_as_admin

  # GET /videos_simposios
  # GET /videos_simposios.json
  def index
    @videos_simposios = VideosSimposio.all
  end

  # GET /videos_simposios/new
  def new
    @videos_simposio = VideosSimposio.new
  end

  # GET /videos_simposios/1/edit
  def edit
    @simposio_videos = VideosSimposio.where("simposio_id = ?", @videos_simposio.simposio_id)
    @simposio_docs = DocumentosSimposio.where("simposio_id = ?", @videos_simposio.simposio_id)
  end

  # POST /videos_simposios
  # POST /videos_simposios.json
  def create
    @videos_simposio = VideosSimposio.new(videos_simposio_params)

    respond_to do |format|
      if @videos_simposio.save
        format.html { redirect_to @videos_simposio, notice: 'Videos simposio was successfully created.' }
        format.json { render :show, status: :created, location: @videos_simposio }
      else
        format.html { render :new }
        format.json { render json: @videos_simposio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos_simposios/1
  # PATCH/PUT /videos_simposios/1.json
  def update
    respond_to do |format|
        if @videos_simposio.update(videos_simposio_params)
          #format.html { redirect_to edit_videos_simposio_path(@videos_simposio), notice: 'Videos simposio was successfully updated.' }
          #format.json { render :show, status: :ok, location: @videos_simposio }
        else
          #format.html { render :edit }
          #format.json { render json: @videos_simposio.errors, status: :unprocessable_entity }
        end
    end
  end

  # DELETE /videos_simposios/1
  # DELETE /videos_simposios/1.json
  def destroy
    if params[:id].to_i != @videos_simposio.id
      @videos_simposio.destroy
    else 
      @videos_simposio.update(:video => nil)
    end
    #respond_to do |format|
    #  format.html { redirect_to videos_simposios_url, notice: 'Videos simposio was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end
  
  def addvideo
    
    @videos_simposio = VideosSimposio.find(params[:id])  
    
    if (!@videos_simposio.video)
      @videos_simposio.update(videos_simposio_params)
    else
      new_videos_simposio = VideosSimposio.new(:video => params[:videos_simposio][:video])
      new_videos_simposio.simposio_id = @videos_simposio.simposio_id
      new_videos_simposio.save
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_videos_simposio
      @videos_simposio = VideosSimposio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def videos_simposio_params
      params.require(:videos_simposio).permit(:simposio_id, :video)
    end
end
