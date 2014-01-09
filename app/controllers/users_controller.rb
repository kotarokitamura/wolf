class UsersController < ApplicationController
  def index
    @menbers = User.get_following_users(current_user)
  end

  def all_users
    # フォーローするために、すべてのUserを表示
    # Show all users to follow
    @all_users = User.all
  end

  def update
  end

  def show
    @user = User.where(id: params[:id]).first
    @user.get_followed_flag(current_user)
  end

end
