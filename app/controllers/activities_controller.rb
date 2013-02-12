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
end
