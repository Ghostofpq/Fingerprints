class ActionPostsController < ApplicationController
  # GET /action_posts
  # GET /action_posts.json
  def index
    @action_posts = ActionPost.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @action_posts }
    end
  end

  # GET /action_posts/1
  # GET /action_posts/1.json
  def show
    @action_post = ActionPost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @action_post }
    end
  end

  # GET /action_posts/new
  # GET /action_posts/new.json
  def new
    @action_post = ActionPost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @action_post }
    end
  end

  # GET /action_posts/1/edit
  def edit
    @action_post = ActionPost.find(params[:id])
  end

  # POST /action_posts
  # POST /action_posts.json
  def create
    @action_post = ActionPost.new(params[:action_post])

    respond_to do |format|
      if @action_post.save
        format.html { redirect_to @action_post, notice: 'Action post was successfully created.' }
        format.json { render json: @action_post, status: :created, location: @action_post }
      else
        format.html { render action: "new" }
        format.json { render json: @action_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /action_posts/1
  # PUT /action_posts/1.json
  def update
    @action_post = ActionPost.find(params[:id])

    respond_to do |format|
      if @action_post.update_attributes(params[:action_post])
        format.html { redirect_to @action_post, notice: 'Action post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @action_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /action_posts/1
  # DELETE /action_posts/1.json
  def destroy
    @action_post = ActionPost.find(params[:id])
    @action_post.destroy

    respond_to do |format|
      format.html { redirect_to action_posts_url }
      format.json { head :no_content }
    end
  end
end
