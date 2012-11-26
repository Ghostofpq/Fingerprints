class ActionPostsController < ApplicationController
  def index
    @action_posts = ActionPost.all
  end

  def show
    @action_post = ActionPost.find(params[:id])
  end

  def new
    @action_post = current_user.action_posts.build
    @action_post.action_id = params[:action_id]
  end

  def edit
    @action_post = ActionPost.find(params[:id])
  end

  def create    
    @action_post = current_user.action_posts.build(params[:action_post])
    @action_post.action_id = params[:action_id]  
    
    if @action_post.save
      flash[:success] = "ActionPost created!"
      redirect_to root_url
    else
      flash[:error] = "ActionPost not created!"
      redirect_to root_url
    end
  end

  def update
    @action_post = ActionPost.find(params[:id])
  end

  def destroy
    @action_post = ActionPost.find(params[:id])
    @action_post.destroy
  end
  
  def set_private
    @action_post = current_user.action_posts.find_by_id(params[:id])
    if @action_post.update_attribute(:public,false)
      flash[:success] = "Set in private mode"
      redirect_back_or root_url
    else
    end

  end

  def set_public
   @action_post = current_user.action_posts.find_by_id(params[:id])
    if @action_post.update_attribute(:public,true)
      flash[:success] = "Set in public mode"
      redirect_back_or root_url
    else
    end
  end

  private

  def correct_user
    @action_post = current_user.microposts.find_by_id(params[:id])
    redirect_to root_url if @action_post.nil?
  end
end
