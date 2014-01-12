class UserRelationshipsController < ApplicationController
  UNFOLLOW_FLAG = "0"
  FOLLOW_FLAG = "1"
  def update
    case params[:user][:followed_flag]
    when FOLLOW_FLAG
      relationship = UserRelationship.get_relationship(current_user,params)
      UserRelationship.create(follower_id: current_user.id, followed_id: params[:id]) if relationship.nil?
    when UNFOLLOW_FLAG
      relationship = UserRelationship.get_relationship(current_user,params)
      UserRelationship.delete(relationship.id) unless relationship.nil?
    end
    redirect_to :user
  end
end
