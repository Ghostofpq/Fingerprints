class ActivitiesController < ApplicationController
  before_filter :admin_user,     only: [:new,:create,:edit,:admin_activities,:update]
  def index
    if(params[:filter]=="all")
      @activities=Activity.all
    elsif(params[:filter]=="Duty")
      @activities=Activity.find_all_by_category("Duty")
    elsif(params[:filter]=="Sports")
      @activities=Activity.find_all_by_category("Sports")
    elsif(params[:filter]=="Leisure")
      @activities=Activity.find_all_by_category("Leisure")
    elsif(params[:filter]=="Routine")
      @activities=Activity.find_all_by_category("Routine")
    else
      @activities=Activity.all
    end
  end

  def new
    @activity=Activity.new
  end

  def create
    @activity = Activity.new(params[:activity])
    if @activity.save
      sign_in @activity
      redirect_to root_path
    else
      render 'new'
    end
  end

  def admin_activities
    @activities=Activity.all
  end

  def edit
    @activity=Activity.find(params[:id])
  end

  def update
    @activity=Activity.find(params[:id])
    @activity.update_attribute(:name,params[:activity][:name])
    @activity.update_attribute(:past_participle,params[:activity][:past_participle])
    @activity.update_attribute(:pic_path,params[:activity][:pic_path])
    @activity.update_attribute(:category,params[:activity][:category])
    @activity.update_attribute(:has_price,params[:activity][:has_price])
    @activity.update_attribute(:has_place,params[:activity][:has_place])
    @activity.update_attribute(:has_score,params[:activity][:has_score])
    @activity.update_attribute(:has_comment,params[:activity][:has_comment])
    @activity.update_attribute(:has_duration,params[:activity][:has_duration])
    tab_achievements=params[:post][:achievements].split
    tab_achievements.each do |ach|
      if(ach.to_i>=0)
        @activity.references!(Achievement.find(ach.to_i))
      end
    end
    @activity.save!
    redirect_to root_url
  end

  def delete

  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
