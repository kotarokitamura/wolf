class UserRelationshipsController < ApplicationController
  before_filter  :check_already_sign_in

  def update
    case params[:user][:followed_flag].to_i
    when ResourceProperty.user_followed
      relationship = current_user.user_relationships.where(["user_id = ? and followed_id = ?", current_user.id, params[:id]]).first || current_user.user_relationships.build(followed_id: params[:id]).save
    when ResourceProperty.user_unfollowed
      relationship = UserRelationship.get_relationship(current_user,params)
      UserRelationship.delete(relationship.id) unless relationship.nil?
    end
    redirect_to controller: "users", action: "all_users"
  end
end
