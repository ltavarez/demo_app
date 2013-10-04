class StaticPageController < ApplicationController
  def home
    if signed_in?
      @minipost  = current_user.miniposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end
end
