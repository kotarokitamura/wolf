class UsersController < ApplicationController
  before_filter  :check_already_sign_in
  def index
    @menbers = User.get_following_users(current_user)
    @menbers.each do |user|
      user.posts.first.nil? ? user.posts.build.save_latest_contents(user) : user.posts.first.save_latest_contents(user)
    @menbers.map{|user| user.alreacy_checked_flag = current_user.user_relationships.where(followed_id: user.id).first.already_check?(user)}
    end
  end

  def all_users
    @all_users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.where(id: params[:id]).first
    @user.get_followed_flag(current_user)
    render 'self_show' if current_user_id?
  end

  def other_accounts
    raise ForbiddenError unless current_user_id?
  end
end
