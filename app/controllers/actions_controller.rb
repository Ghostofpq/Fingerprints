class ActionsController < ApplicationController
  def index
    if(params[:filter]=="all")
      @actions=Action.all
    elsif(params[:filter]=="Social")
      @actions=Action.find_all_by_category("Social")
    elsif(params[:filter]=="Sport")
      @actions=Action.find_all_by_category("Sport")
    elsif(params[:filter]=="Loisir")
      @actions=Action.find_all_by_category("Loisir")
    elsif(params[:filter]=="Vie")
      @actions=Action.find_all_by_category("Vie")
    else
      @actions=Action.all
    end

  end
end
