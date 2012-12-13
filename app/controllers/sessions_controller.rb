class SessionsController < ApplicationController
  def new
  end

  def fb_auth
    auth_hash = request.env["omniauth.auth"]
    if signed_in?
      #L'utilisateur est connecté, on lui rajoute FB
      @authorisation= current_user.authorizations.build(:provider => auth_hash["provider"], :uid => auth_hash["uid"],:token => (auth_hash["credentials"]["token"] rescue nil))
      if @authorisation.save
        flash[:success] = "Your Facebook account has been linked"
        redirect_to root_url
      else
        flash[:error] = "Your Facebook account has not been linked"
        redirect_to root_url
      end
    else
    #L'utilisateur n'est connecté, on cherche son FB voir si il a un compte
      auth=Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      if(auth!=nil)
        #si oui on fait le lien et on le connecte
        user = User.find_by_id(auth.user_id)
        sign_in user
        redirect_to root_url
      else
      #sinon on lui créé un compte et on lui lie FB
        user= User.find_by_email(auth_hash['info']['email'])
        if(user==nil)
          @user=User.new(:name=>auth_hash['info']['name'],:email=>auth_hash['info']['email'],:password=>"123456",:password_confirmation=>"123456")
          if @user.save
            sign_in @user
            @authorisation= current_user.authorizations.build(:provider => auth_hash["provider"], :uid => auth_hash["uid"],:token => (auth_hash["credentials"]["token"] rescue nil))
            if @authorisation.save
              flash[:success] = "Your Facebook account has been linked"
              redirect_to root_url
            else
              flash[:error] = "Your Facebook account has not been linked"
              redirect_to root_url
            end
          end
        else
          @authorisation= user.authorizations.build(:provider => auth_hash["provider"], :uid => auth_hash["uid"],:token => (auth_hash["credentials"]["token"] rescue nil))
          if @authorisation.save
            flash[:success] = "Your Facebook account has been linked"
            sign_in user
            redirect_to root_url
          else
            flash[:error] = "Your Facebook account has not been linked"
            redirect_to root_url
          end
        end
      end
    end
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or root_url
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