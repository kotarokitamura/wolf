class OtherAccount < ActiveRecord::Base
  belongs_to :user

  def self.create_with_omniauth(auth,current_user)
    create! do |other_account|
      other_account.user_id = current_user.id
      other_account.provider = auth["provider"]
      other_account.uid = auth["uid"]
      other_account.name = auth["info"]["name"]
      other_account.access_token = auth["credentials"]["token"]
      other_account.image_url = auth["info"]["image"]
    end
  end
end
