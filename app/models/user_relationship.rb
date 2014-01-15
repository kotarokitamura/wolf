class UserRelationship < ActiveRecord::Base

  validates :user_id, presence: :true
  validates :followed_id, presence: :true

  belongs_to :user
  def update_last_checked_time
    self.update_attributes(last_checked_at: Time.now)
  end
end
