# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  private
    # Check and create session
    # セッションの確認と確立
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
