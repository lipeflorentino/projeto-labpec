class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :logged_as_admin, only: [:edit, :update, :destroy, :create, :index, :new]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post.update(:vezes_visitado => @post.vezes_visitado + 1)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    params[:post][:user_id] = current_user.id
    @post = Post.new(post_params)
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Publicação criada com sucesso!' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Alterações aplicadas.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Publicação apagada.' }
      format.json { head :no_content }
    end
  end

  private
    def logged_as_admin
      unless administrador?
        flash[:danger] = "Você não tem permissão para entrar aqui"
        redirect_to(root_path)
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:titulo, :descricao, :user_id, :picture, :conteudo, :vezes_visitado)
    end
end
