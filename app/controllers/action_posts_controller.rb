class ActionPostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: [:destroy,:set_public,:set_private,:edit]
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
    if @action_post.start_date.future? or @action_post.end_date.future?
      flash[:error] = "You've seen the future? Tell me more about that."
      redirect_to root_url
    elsif @action_post.start_date > @action_post.end_date
      flash[:error] = "You're fucking the space time continuum aren't you?"
      redirect_to root_url
    else
      if @action_post.save
        flash[:success] = "ActionPost created!"
        redirect_to root_url
      else
        flash[:error] = "ActionPost not created!"
        redirect_to root_url
      end
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
