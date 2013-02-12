class ActivitiesController < ApplicationController
  def index
    if(params[:filter]=="all")
      @actions=Activity.all
    elsif(params[:filter]=="Duty")
      @actions=Activity.find_all_by_category("Duty")
    elsif(params[:filter]=="Sports")
      @actions=Activity.find_all_by_category("Sports")
    elsif(params[:filter]=="Leisure")
      @actions=Activity.find_all_by_category("Leisure")
    elsif(params[:filter]=="Routine")
      @actions=Activity.find_all_by_category("Routine")
    else
      @actions=Activity.all
    end

  end
end
