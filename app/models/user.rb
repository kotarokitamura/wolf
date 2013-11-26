class User < ActiveRecord::Base
  validates :uid, presence: :true
  validates :name, presence: :true

  validates_uniqueness_of :uid

  def self.create_with_omniauth(auth)
    return false if auth["provider"] != "facebook"
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
    end
  end
end
