class UsersController < ApplicationController
  def index
    current_user.update_last_checked_time
    @menbers = User.get_following_users(current_user)
    @menbers.each do |user|
      user.posts.first.save_latest_contents(user)
    end
  end

  def all_users
    @all_users = User.all
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
