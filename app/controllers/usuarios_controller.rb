class UsuariosController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  def index
    @usuarios = Usuario.paginate(page: params[:page])
  end

  def show
    @usuario = Usuario.find(params[:id])
    @miniposts = @usuario.miniposts.paginate(page: params[:page])
  end

  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.new(usuario_params)
    if @usuario.save
      flash[:success] = "User was successfully created"
      redirect_back_or @usuario
    else
      render 'new'
    end
  end

  def edit
    @usuario = Usuario.find(params[:id])
  end

  def update
    @usuario = Usuario.find(params[:id])
    if @usuario.update_attributes(usuario_params)
      flash[:success] = "Profile updated"
      redirect_to @usuario
    else
      render 'edit'
    end
  end

  def destroy
    Usuario.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to usuarios_path
  end

  private

  def usuario_params
    params.require(:usuario).permit(:nombre,:email,:password)
  end

  # Before filters

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to new_session_path, notice: "Please sign in."
    end
  end

  def correct_user
    @usuario = Usuario.find(params[:id])
    redirect_to(root_url) unless current_user?(@usuario)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
