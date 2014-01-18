class UserRelationship < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: :true
  validates :followed_id, presence: :true

  def update_last_checked_time
    self.update_attributes(last_checked_at: Time.now)
  end

  def already_check?(user)
    return true if self.last_checked_at.nil?
    user.posts.first.posted_at > self.last_checked_at
  end

  def self.get_relationship(current_user,params)
    UserRelationship.where(["user_id = ? and followed_id = ?", current_user.id, params[:id]]).first
  end
end
