class AchievementsController < ApplicationController
  before_filter :admin_user,     only: [:new,:create,:edit,:admin_achievements,:update]
  def admin_achievements
    @achievements=Achievement.all
  end

  def new
    @achievement=Achievement.new
  end

  def create
    @achievement = Achievement.new(params[:achievement])
    if @achievement.save
      redirect_to "/achievement/admin"
    else
      render 'new'
    end
  end

  def edit
    @achievement=Achievement.find(params[:id])
  end

  def update
    @achievement=Achievement.find(params[:id])
    @achievement.update_attribute(:name,params[:achievement][:name])
    @achievement.update_attribute(:pic_path,params[:achievement][:pic_path])
    @achievement.save!
    redirect_to "/achievements/admin"
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
