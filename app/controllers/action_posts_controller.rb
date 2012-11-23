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
end
