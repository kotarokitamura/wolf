class User < ActiveRecord::Base
  has_many :posts

  validates :uid, presence: :true
  validates :name, presence: :true

  validates_uniqueness_of :uid

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
end
