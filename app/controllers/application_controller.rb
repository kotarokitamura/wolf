# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  rescue_from Exception, :with => :handle_exceptions unless Rails.application.config.consider_all_requests_local

  def check_already_sign_in
    redirect_to root_path unless session[:user_id]
    redirect_to root_path if User.where(id:session[:user_id]).nil?
  end

  def current_user_id?
    params[:id].to_i == current_user.id.to_i
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def handle_exceptions(e)
    case e
    when InvalidUrlError, ActiveRecord::RecordNotFound, ActionController::RoutingError, ActionController::UnknownAction
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
      logger.info("Rendering 404 with exception: #{e.message}")
    when ForbiddenError
      render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
      logger.info("Rendering 403 with exception: #{e.message}")
    else
      render :file => "#{Rails.root}/public/500.html", :status => 500, :layout => false
      logger.info("Rendering 505 with exception: #{e.message}")
    end
  end
end

class InvalidUrlError < ::ActionController::ActionControllerError; end
class ForbiddenError < ::ActionController::ActionControllerError; end
