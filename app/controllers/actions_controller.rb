class ActionsController < ApplicationController
  def index
    if(params[:filter]=="all")
      @actions=Action.all
    elsif(params[:filter]=="Social")
      @actions=Action.find_all_by_category("Social")
    elsif(params[:filter]=="Sports")
      @actions=Action.find_all_by_category("Sports")
    elsif(params[:filter]=="Leisure")
      @actions=Action.find_all_by_category("Leisure")
    elsif(params[:filter]=="Routine")
      @actions=Action.find_all_by_category("Routine")
    else
      @actions=Action.all
    end

  end
end
