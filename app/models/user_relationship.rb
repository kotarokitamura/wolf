class UserRelationship < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: :true
  validates :followed_id, presence: :true

  def update_last_checked_time
    self.update_attributes(last_checked_at: Time.now)
  end

  def already_check?(user)
    user.posts.first.posted_at > self.last_checked_at
  end
end
