class UserRelationshipsController < ApplicationController
  UNFOLLOW_FLAG = "0"
  FOLLOW_FLAG = "1"
  before_filter  :check_already_sign_in
  def update
    case params[:user][:followed_flag]
    when FOLLOW_FLAG
      relationship = current_user.user_relationships.where(["user_id = ? and followed_id = ?", current_user.id, params[:id]]).first || current_user.user_relationships.build(followed_id: params[:id]).save
    when UNFOLLOW_FLAG
      relationship = UserRelationship.get_relationship(current_user,params)
      UserRelationship.delete(relationship.id) unless relationship.nil?
    end
    redirect_to :user
  end
end
