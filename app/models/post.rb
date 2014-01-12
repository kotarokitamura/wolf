class Post < ActiveRecord::Base
  belongs_to :user
  TWITTER_CONSUMER_KEY = "qQb1VxwVDyVJ4mRvmaZ0g"
  TWITTER_CONSUMER_SECRET = "oO6V2rIlJOAJ1LSf5qgzd0KSkJCVvl3SfjSGEmr98"

  def save_latest_contents(current_user)
    self.user_id = current_user.id
    contents = []
    contents <<  last_twitter_contents(current_user)
    contents <<  last_facebook_contents(current_user)
    contents.each do |content|
      judge = []
      judge << self.content_nil?
      judge << self.content_new?(content)
      self.body = content.body if judge.include?(true)
      self.posted_at = content.posted_at if judge.include?(true)
    end
    Post.exists?(user_id: current_user.id).nil? ? self.save : self.update(user_id: current_user.id)
  end

  def content_new?(content)
    self.posted_at < content.posted_at
  end

  def content_nil?
    self.posted_at.nil?
  end

  def last_twitter_contents(current_user)
    user_twitter_account = current_user.other_accounts.where(provider: "twitter").first
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = TWITTER_CONSUMER_KEY
      config.consumer_secret = TWITTER_CONSUMER_SECRET
      config.access_token = user_twitter_account.access_token
      config.access_token_secret = user_twitter_account.access_token_secret
    end
    last_tweet =  Post.new
    last_tweet.body = client.user_timeline(user_twitter_account.uid.to_i, :count => 1).first.text
    last_tweet.posted_at = client.user_timeline(user_twitter_account.uid.to_i, :count => 1).first.created_at
    last_tweet
  end

  def last_facebook_contents(current_user)
    graph = Koala::Facebook::API.new(current_user.access_token)
    contents = graph.get_connections("me", "feed")

    contents.sort!{ |a, b| b[:updated_time] <=> a[:updated_time] }

    last_content = Post.new
    contents.each do |content|
      next unless content.keys.include?("message")
      last_content.body = content["message"]
      last_content.posted_at = content["updated_time"]
      break
    end
    last_content
  end
end
