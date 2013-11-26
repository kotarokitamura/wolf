class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    debugger
    user = (User.find_by uid: auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed In!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed Out!"
  end

  def sign_in
  end
end
