class ActivitiesController < ApplicationController
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

  end

  def admin_activities
    if current_user.admin?
      @activities=Activity.all
    else
      redirect_to
    end
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
    redirect_to root_url
  end

  def delete

  end
end
