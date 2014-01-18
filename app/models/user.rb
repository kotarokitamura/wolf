class User < ActiveRecord::Base
  attr_accessor :followed_flag, :alreacy_checked_flag
  has_many :posts
  has_many :other_accounts
  has_many :user_relationships
  has_many :comments

  validates :uid, presence: :true
  validates :name, presence: :true

  validates_uniqueness_of :uid

  def self.get_following_users(current_user)
    relations = UserRelationship.where(user_id: current_user.id)
    menbers = []
    relations.map {|relation| menbers << User.where(id: relation.followed_id).first}
    menbers
  end

  def self.create_with_omniauth(auth)
    return false if auth["provider"] != "facebook"
    create! do |user|
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.image_url = auth["info"]["image"]
      user.first_name = auth["info"]["first_name"]
      user.last_name = auth["info"]["last_name"]
      user.access_token = auth["credentials"]["token"]
    end
  end

  def get_followed_flag(current_user)
    menbers = User.get_following_users(current_user)
    follow_id = []
    menbers.map {|menber| follow_id << menber.id}
    self.followed_flag = follow_id.include?(self.id)? 1 : 0
  end
end
