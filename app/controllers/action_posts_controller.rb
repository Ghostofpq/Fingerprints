class ActionPostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: [:destroy,:set_public,:set_private,:edit]
  def new
    @action_post = current_user.action_posts.build
    @action_post.action_id = params[:action_id]
  end

  def edit
    @action_post = ActionPost.find(params[:id])
  end

  def create
    @s_date=params["action_post"]["start_date"]
    @e_date=params["action_post"]["end_date"] 
    
    @action_post = current_user.action_posts.build(params[:action_post])
    @action_post.start_date=DateTime.parse(@s_date)
    @action_post.end_date=DateTime.parse(@e_date)
    
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
    @action_post_u = ActionPost.find(params[:id])

    @date1= DateTime.parse(params["action_post"]["start_date"])
    @date2= DateTime.parse(params["action_post"]["end_date"])

    if @date1.future? or @date2.future?
      flash[:error] = "You've seen the future? Tell me more about that."
      redirect_to root_url
    elsif @date1 > @date2
      flash[:error] = "You're fucking the space time continuum aren't you?"
      redirect_to root_url
    else
      @action_post_u.update_attribute(:start_date,@date1)
      @action_post_u.update_attribute(:end_date,@date2)
      @action_post_u.update_attribute(:comment,params[:action_post][:comment])
      @action_post_u.update_attribute(:place,params[:action_post][:place])
      @action_post_u.update_attribute(:score,params[:action_post][:score])
      @action_post_u.update_attribute(:price,params[:action_post][:price].to_f)

      redirect_to root_url
    end
  end

  def destroy
    @action_post = ActionPost.find(params[:id])
    @action_post.destroy
    redirect_to root_url
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

  def publish_on_fb
    @action_post = current_user.action_posts.find_by_id(params[:id])
    if current_user.has_provider("facebook")
      current_user.publish(@action_post,"facebook")
      flash[:success] = "Posted on Facebook"
      redirect_back_or root_url
    end
  end

  private

  def correct_user
    @action_post = current_user.action_posts.find_by_id(params[:id])
    redirect_to root_url if @action_post.nil?
  end
end
