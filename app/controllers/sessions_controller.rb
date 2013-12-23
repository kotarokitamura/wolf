class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = (User.find_by uid: auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    #@contents = (Post.find_by user_id: current_user.id) || Post.new
    #@contents.save_latest_contents(current_user)
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def sign_in
  end
end
