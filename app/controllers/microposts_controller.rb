class MicropostsController < ApplicationController
  def index
    @microposts = Micropost.all
  end

  def show
    @micropost = Micropost.find(params[:id])
  end

  def new
    @micropost = Micropost.new
  end

  def edit
    @micropost = Micropost.find(params[:id])
  end

  def create
    @micropost = Micropost.new(params[:micropost])
  end

  def update
    @micropost = Micropost.find(params[:id])
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
  end
end
