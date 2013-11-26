class UsersController < ApplicationController
  def index
    current_user
    relations = UserRelationship.where(follower_id: @current_user.id)
    @menbers = []
    relations.map {|relation| @menbers << User.where(id: relation.followed_id).first}
  end
end
