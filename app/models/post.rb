class Post < ActiveRecord::Base
  belongs_to :user
  HOLD_ON = 1
  HOLD_OFF = 0
  TWITTER_CONSUMER_KEY = "qQb1VxwVDyVJ4mRvmaZ0g"
  TWITTER_CONSUMER_SECRET = "oO6V2rIlJOAJ1LSf5qgzd0KSkJCVvl3SfjSGEmr98"

  def save_latest_contents(user)
    return nil if user.posts.first.hold_flag == HOLD_ON
    self.user_id = user.id
    contents = []
    contents << Post.where(user_id: user.id).first
    contents << last_twitter_contents(user) unless user.other_accounts.where(provider: "twitter").first.nil?
    contents << last_facebook_contents(user)
    contents.each do |content|
      judge = []
      judge << self.content_nil?
      judge << self.content_new?(content)
      if judge.include?(true)
        next if content.nil?
        self.body = content.body
        self.posted_at = content.posted_at
        self.provider = content.provider
        self.hold_flag = HOLD_OFF
      else
      end
    end
    Post.exists?(user_id: user.id).nil? ? self.save : self.update(user_id: user.id)
  end

  def content_new?(content)
    self.posted_at.nil? ? true : (self.posted_at < content.posted_at)
  end

  def content_nil?
    self.posted_at.nil?
  end

  def last_twitter_contents(user)
    user_twitter_account = user.other_accounts.where(provider: "twitter").first
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = TWITTER_CONSUMER_KEY
      config.consumer_secret = TWITTER_CONSUMER_SECRET
      config.access_token = user_twitter_account.access_token
      config.access_token_secret = user_twitter_account.access_token_secret
    end
    last_tweet =  Post.new
    last_tweet.body = client.user_timeline(user_twitter_account.uid.to_i, :count => 1).first.text
    last_tweet.posted_at = client.user_timeline(user_twitter_account.uid.to_i, :count => 1).first.created_at
    last_tweet.provider = "twitter"
    last_tweet
  end

  def last_facebook_contents(user)
    graph = Koala::Facebook::API.new(user.access_token)
    contents = graph.get_connections("me", "feed")

    contents.sort!{ |a, b| b[:updated_time] <=> a[:updated_time] }

    last_content = Post.new
    contents.each do |content|
      next unless content.keys.include?("message")
      last_content.body = content["message"]
      last_content.posted_at = content["updated_time"]
      break
    end
     last_content.provider = "facebook"
    last_content
  end
end
