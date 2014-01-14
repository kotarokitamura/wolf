class UsersController < ApplicationController
  def index
    @menbers = User.get_following_users(current_user)
    @menbers.each do |user|
      user.posts.first.nil? ? user.posts.build.save_latest_contents(user) : user.posts.first.save_latest_contents(user)
    end
  end

  def all_users
    @all_users = User.where.not(id: current_user.id)
  end

  def update
  end

  def show
    @user = User.where(id: params[:id]).first
    @user.get_followed_flag(current_user)
  end

  def other_accounts
  end

end
