class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :editemail, :editpassword]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end
  
  def editemail
    if logged_in?
        @user = current_user
    end
  end
  
  def editemailupdate
    if logged_in?
      @user = current_user
    else
      @user = User.find_by(params[:id])
    end
    
    if @user && @user.authenticate(params[:user][:actual_password])
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'Email was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :editemail }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      flash.now[:danger] = 'Senha inválida'
      render 'editemail'
    end
  end

  def editpassword
    if logged_in?
        @user = current_user
    end
  end
  
  def editpasswordupdate
    if logged_in?
      @user = current_user
    else
      @user = User.find_by(params[:id])
    end
    if @user && @user.authenticate(params[:user][:actual_password])
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'Email was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :editpassword }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      flash.now[:danger] = 'Senha inválida'
      render 'editpassword'
    end
  end
  
  # POST /users
  # POST /users.json
  def create
    
    @user = User.new(user_params)
    
    if !administrador?
      @user.adm = false
    end
    
    respond_to do |format|
      if @user.save
        @user.send_activation_email
        format.html { redirect_to @user, notice: 'Confirme seu e-mail' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :adm, :matricula, :password, :password_confirmation, :email_confirmation, :picture, :actual_password)
    end
end
