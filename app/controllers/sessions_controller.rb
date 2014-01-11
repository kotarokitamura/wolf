class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    if auth["provider"] == "facebook"
      user = (User.find_by uid: auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    else
      user = OtherAccount.find_by_provider_and_uid(auth["provider"], auth["uid"]) || OtherAccount.create_with_omniauth(auth,current_user)
    #Twitter.configure do |config|
    #  config.oauth_token = auth['credentials']['token']
    #  config.oauth_token_secret = auth['credentials']['secret']
    #end
      session[:user_id] = user.user_id
    end
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def sign_in
  end
end
