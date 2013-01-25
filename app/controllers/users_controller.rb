class UsersController < ApplicationController
  include ActionView::Helpers::DateHelper
  before_filter :signed_in_user,
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update,:stats,:unlink_facebook]
  before_filter :admin_user,     only: :destroy
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @global_feed_items = @user.self_feed_public+@user.self_action_feed_public
    @global_feed_items.sort! {|obj1, obj2| (obj2.date_sort) <=> (obj1.date_sort)}
    @achievements = @user.achievements
  end

  def new
    @user = User.new
  end

  def edit
  end

  def calendar
    @user = User.find(params[:id])

    if(params[:date]==nil)
      params[:date]=Date.today
    end
    @date_cal=params[:date]

    @action=@user.action_posts.where(:start_date==@date)
    @actions_in_e=@user.action_posts.where(:end_date==@date)

    @actions_in_e.each do |action_end|
      unless (@action.include?(action_end))
      @action.push(action_end)
      end
    end

  end

  def stats
    @user = User.find(params[:id])
    @filter=params[:filter]
    if (@filter==nil)
      @filter="time"
    end
    if(@filter=="time")
      @filter="time"
      @time=0

      @time=@user.total_time_doing("Work")
      if(@time>0)
        @work="Time spent working : "+distance_of_time_in_words(@time,0,true)
      else
        @work=""
      end

      @time=@user.total_time_doing("Study")
      if(@time>0)
        @study="Time spent studying : "+distance_of_time_in_words(@time,0,true)
      else
        @study=""
      end

      @time=@user.total_time_doing("Wash")
      if(@time>0)
        @wash="Time spent washing : "+distance_of_time_in_words(@time,0,true)
      else
        @wash=""
      end

      @time=@user.total_time_doing("Eat")
      if(@time>0)
        @eat="Time spent eating : "+distance_of_time_in_words(@time,0,true)
      else
        @eat=""
      end

      @time=@user.total_time_doing("Sleep")
      if(@time>0)
        @sleep="Time spent sleeping : "+distance_of_time_in_words(@time,0,true)
      else
        @sleep=""
      end

      @time=@user.total_time_doing("Coffee")
      if(@time>0)
        @coffee="Time spent drinking coffee : "+distance_of_time_in_words(@time,0,true)
      else
        @coffee=""
      end

    elsif(@filter=="money")
      @filter="money"

      @price=0

      @price=@user.total_spent_doing("Work")
      if(@price>0)
        @work="Money spent working : "+@price.to_s
      else
        @work=""
      end

      @price=@user.total_spent_doing("Study")
      if(@price>0)
        @study="Money spent studying : "+@price.to_s
      else
        @study=""
      end

      @price=@user.total_spent_doing("Wash")
      if(@price>0)
        @wash="Money spent washing : "+@price.to_s
      else
        @wash=""
      end

      @price=@user.total_spent_doing("Eat")
      if(@price>0)
        @eat="Money spent eating : "+@price.to_s
      else
        @eat=""
      end

      @price=@user.total_spent_doing("Sleep")
      if(@price>0)
        @sleep="Money spent sleeping : "+@price.to_s
      else
        @sleep=""
      end

      @price=@user.total_spent_doing("Coffee")
      if(@price>0)
        @coffee="Money spent drinking coffee : "+@price.to_s
      else
        @coffee=""
      end
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Fingerprints!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def unlink_facebook
    @user = User.find(params[:id])
    @user.authorizations.find_by_provider("facebook").destroy
    flash[:success] = "Facebook is no longer linked to this account"
    redirect_to root_path
  end

  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
