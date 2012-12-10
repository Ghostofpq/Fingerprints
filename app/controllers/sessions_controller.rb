class SessionsController < ApplicationController
  def new
  end

  def add_fb
    auth_hash = request.env["omniauth.auth"]
    if signed_in?
      @authorisation= current_user.authorizations.build(:provider => auth_hash["provider"], :uid => auth_hash["uid"])
      if @authorisation.save
        flash[:success] = "Your Facebook account has been linked"
        redirect_to root_url
      else
        flash[:error] = "Your Facebook account has not been linked"
        redirect_to root_url
      end
    else
      auth=Authorization.find(auth_hash)
      if(auth!=nil)
        user = auth.user
        sign_in user
        redirect_to root_url
      end
      flash.now[:error] = 'Please create an account'
      redirect_to root_url
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

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end