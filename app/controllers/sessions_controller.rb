class SessionsController < ApplicationController
  def new
  end

  def create_with_fb
    auth_hash = request.env['omniauth.auth']
    @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    if @authorization
      render :text => "Welcome back #{@authorization.user.name}! You have already signed up."
    else
      user = User.new :name => auth_hash["user_info"]["name"], :email => auth_hash["user_info"]["email"],:password => "123456",:password_confirmation => "123456"
      user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
      user.save
      render :text => "Hi #{user.name}! You've signed up."
    end
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end