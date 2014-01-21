class OtherAccount < ActiveRecord::Base
  belongs_to :user

  validates :uid, presence: :true
  validates :user_id, presence: :true
  validates :name,
            :length => {:maximum => ResourceProperty.name_max_length}
  validates :email,
            :length => {:maximum => ResourceProperty.email_max_length}

  validates_uniqueness_of :uid

  def self.create_with_omniauth(auth,current_user)
    create! do |other_account|
      other_account.user_id = current_user.id
      other_account.provider = auth["provider"]
      other_account.uid = auth["uid"]
      other_account.name = auth["info"]["name"]
      other_account.access_token = auth["credentials"]["token"]
      other_account.access_token_secret = auth["credentials"]["secret"]
      other_account.image_url = auth["info"]["image"]
    end
  end
end
