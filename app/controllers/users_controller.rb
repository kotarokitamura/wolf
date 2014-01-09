class UsersController < ApplicationController
  def index
    get_following_users
  end

  def all_users
    # フォーローするために、すべてのUserを表示
    # Show all users to follow
    @all_users = User.all
  end

  def update
  end

  def show
    current_user
    # フォローしているユーザーのIDだけを抽出
    # Get some ID only current user following
    get_following_users
    follow_id = []
    @menbers.map {|menber| follow_id << menber.id}

    @user = User.where(id: params[:id]).first
    @user.followed_flag = follow_id.include?(@user.id)? 1 : 0
  end

private
  def get_following_users
    # ログインユーザーがフォローしているユーザーを取得
    # Get users who current user following
    current_user
    relations = UserRelationship.where(follower_id: @current_user.id)
    @menbers = []
    relations.map {|relation| @menbers << User.where(id: relation.followed_id).first}
  end
end
