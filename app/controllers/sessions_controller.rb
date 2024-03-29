class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    if auth["provider"] == "facebook"
      get_facebook_account(auth)
    else
      get_twitter_account(auth)
    end
    current_user.posts.build.save_latest_contents(current_user)
    redirect_to users_path
  end

  def get_facebook_account(auth)
    user = (User.find_by uid: auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
  end

  def get_twitter_account(auth)
    user = OtherAccount.find_by_provider_and_uid(auth["provider"], auth["uid"]) || OtherAccount.create_with_omniauth(auth,current_user)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ResourceProperty.twitter_consumer_key
      config.consumer_secret     = ResourceProperty.twitter_consumer_secret
      config.access_token        = auth['credentials']['token']
      config.access_token_secret = auth['credentials']['secret']
    end
  end

  def sign_in
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
