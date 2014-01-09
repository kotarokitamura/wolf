class UsersController < ApplicationController
  def index
    # ログインユーザーがフォローしているユーザーを取得
    # Get users who current user following
    current_user
    relations = UserRelationship.where(follower_id: @current_user.id)
    @menbers = []
    relations.map {|relation| @menbers << User.where(id: relation.followed_id).first}
  end

  def all_users
    # フォーローするために、すべてのUserを表示
    # Show all users to follow
    @all_users = User.all
  end
end
