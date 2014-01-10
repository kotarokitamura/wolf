class UserRelationshipsController < ApplicationController
  UNFOLLOW_FLAG = "0"
  FOLLOW_FLAG = "1"
  def update
    case params[:user][:followed_flag]
    # when change to follow
    when FOLLOW_FLAG
      relationship = UserRelationship.get_relationship(current_user,params)
      # Add relationship function
      UserRelationship.create(follower_id: current_user.id, followed_id: params[:id]) if relationship.nil?

    when UNFOLLOW_FLAG
      # when change to unfollow
      relationship = UserRelationship.get_relationship(current_user,params)
      UserRelationship.delete(relationship.id) unless relationship.nil?
    end
    redirect_to :user
  end
end
