class SessionsController < ApplicationController
  TWITTER_CONSUMER_KEY = "qQb1VxwVDyVJ4mRvmaZ0g"
  TWITTER_CONSUMER_SECRET = "oO6V2rIlJOAJ1LSf5qgzd0KSkJCVvl3SfjSGEmr98"
  def create
    auth = request.env["omniauth.auth"]
    if auth["provider"] == "facebook"
      get_facebook_account
    else
      # 現在取得しうるのがTwitterだけなので、これでよいが…増える場合は条件分岐を増やす
      get_twitter_account
    end
    #latest_tweet = client.user_timeline(116145380,:count => 1).first.text
    redirect_to root_url
  end

  def get_facebook_account
    user = (User.find_by uid: auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
  end

  def get_twitter_account
    user = OtherAccount.find_by_provider_and_uid(auth["provider"], auth["uid"]) || OtherAccount.create_with_omniauth(auth,current_user)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = TWITTER_CONSUMER_KEY
      config.consumer_secret     = TWITTER_CONSUMER_SECRET
      config.access_token        = auth['credentials']['token']
      config.access_token_secret = auth['credentials']['secret']
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def sign_in
  end
end
