class UserRelationship < ActiveRecord::Base
  def self.get_relationship(current_user,params)
    UserRelationship.where(["follower_id = ? and followed_id = ?", current_user.id, params[:id]]).first
  end
end
