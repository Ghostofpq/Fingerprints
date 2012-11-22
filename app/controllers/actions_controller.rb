class ActionsController < ApplicationController
  def index
    @actions=Action.all
  end
end
