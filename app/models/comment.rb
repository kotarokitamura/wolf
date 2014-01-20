class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :body,
            :length => {:maximum => ResourceProperty.comment_max_length},
            :presence => true
  validates :post_id,
            :presence => true
  validates :user_id,
            :presence => true
end
