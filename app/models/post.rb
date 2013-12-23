class Post < ActiveRecord::Base
  belongs_to :user

  def save_latest_contents(current_user)
    get_facebook_contents(current_user)
  end

  def get_facebook_contents(current_user)
    # the first step is get only latest post
    graph = Koala::Facebook::API.new(current_user.access_token)
    contents = graph.get_connections("me", "feed")
    contents.sort!{ |a, b| b[:updated_time] <=> a[:updated_time] }
    contents.each do |content|
      next unless content.keys.include?("message")
      self.user_id = current_user.id
      self.body = content["message"]
      self.posted_at = content["updated_time"]
      break
    end
    Post.exists?(user_id: current_user.id).nil? ? self.save : self.update(user_id: current_user.id)
  end
end
