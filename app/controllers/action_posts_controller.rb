class ActionPostsController < ApplicationController
  def index
    @action_posts = ActionPost.all
  end

  def show
    @action_post = ActionPost.find(params[:id])
  end

  def new
    @action_post = ActionPost.new
  end

  def edit
    @action_post = ActionPost.find(params[:id])
  end

  def create
    @action_post = ActionPost.new(params[:action_post])
  end

  def update
    @action_post = ActionPost.find(params[:id])
  end

  def destroy
    @action_post = ActionPost.find(params[:id])
    @action_post.destroy
  end
end
