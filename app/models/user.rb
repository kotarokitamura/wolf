class User < ActiveRecord::Base
  attr_accessor :followed_flag
  has_many :posts
  has_many :other_accounts

  validates :uid, presence: :true
  validates :name, presence: :true

  validates_uniqueness_of :uid

  # ログインユーザーがフォローしているユーザーを取得
  # get users who current user following
  def self.get_following_users(current_user)
    relations = UserRelationship.where(follower_id: current_user.id)
    menbers = []
    relations.map {|relation| menbers << User.where(id: relation.followed_id).first}
    menbers
  end

  # FacebookのAuthを確立する
  # Get facebook auth only
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

  # 現在のIDのユーザーをレシーバにFlagの値を格納する
  def get_followed_flag(current_user)
    menbers = User.get_following_users(current_user)
    follow_id = []
    menbers.map {|menber| follow_id << menber.id}
    self.followed_flag = follow_id.include?(self.id)? 1 : 0
  end

  def update_last_checked_time
    self.update_attributes(last_checked_at: Time.now)
  end
end
