class MinipostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :signed_in_user
  def create
    @minipost = current_user.miniposts.build(minipost_params)
    if @minipost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_page/home'
    end
  end

  def destroy
    Minipost.find(params[:id]).destroy
    flash[:success] = "MicroPost destroyed."
    redirect_to root_path  
    end

  private

  def minipost_params
    params.require(:minipost).permit(:content)
  end

end

