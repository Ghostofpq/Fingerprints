class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: [:destroy,:set_public,:set_private]
  def index
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    @micropost.public=params[:public]
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  def set_private
    @micropost = current_user.microposts.find_by_id(params[:id])
    if @micropost.update_attribute(:public,false)
      flash[:success] = "Set in private mode"
      redirect_back_or root_url
    else
    end

  end

  def set_public
    @micropost = current_user.microposts.find_by_id(params[:id])
    if @micropost.update_attribute(:public,true)
      flash[:success] = "Set in public mode"
      redirect_back_or root_url
    else
    end
  end

  private

  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
