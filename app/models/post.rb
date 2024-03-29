class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  validates :body,
            :length => {:maximum => ResourceProperty.post_body_max_length},
            :presence => true
  validates :user_id,
            :presence => true,
            :numericality => {:only_integer => true}
  validates :hold_flag,
            :numericality => {:only_integer => true}

  def count_post_checked_user
    UserRelationship.where(["followed_id = ? and last_checked_at > ?", self.user.id, self.posted_at]).count
  end

  def save_latest_contents(user)
    return nil if hold_flag_on?(user)
    self.user_id = user.id
    contents = []
    contents << Post.where(user_id: user.id).first
    contents << last_twitter_contents(user) if can_save_tweet?(user)
    contents << last_facebook_contents(user)
    self.check_latest_content(contents)
    Post.exists?(user_id: user.id).nil? ? self.save : self.update_content(user)
  end

  def can_save_tweet?(user)
    return false unless OtherAccount.twitter_account_exist?(user)
    return false unless first_tweet_exist?(user)
    true
  end

  def first_tweet_exist?(user)
    user_twitter_account = user.other_accounts.where(provider: "twitter").first
    client = get_twitter_client(user)
    !client.user_timeline(user_twitter_account.uid.to_i, :count => 1).first.nil?
  end

  def check_latest_content(contents)
    contents.each do |content|
      judge = []
      judge << self.content_nil?
      judge << self.content_new?(content)
      if judge.include?(true)
        next if content.nil?
        self.body = content.body
        self.posted_at = content.posted_at
        self.provider = content.provider
        self.hold_flag = ResourceProperty.post_hold_off
      else
      end
    end
  end

  def update_content(user)
    latest_content = Post.where(user_id: user.id).first
    return nil if latest_content.posted_at == self.posted_at
    Comment.destroy_all(post_id: latest_content.id) if latest_content.update_attributes(body: self.body,provider: self.provider,posted_at: self.posted_at)
  end

  def hold_flag_on?(user)
    return false if user.posts.first.nil?
    user.posts.first.hold_flag == ResourceProperty.post_hold_on
  end

  def content_new?(content)
    self.posted_at.nil? ? true : (self.posted_at < content.posted_at)
  end

  def content_nil?
    self.posted_at.nil?
  end

  def last_twitter_contents(user)
    user_twitter_account = user.other_accounts.where(provider: "twitter").first
    client = get_twitter_client(user)
    last_tweet =  Post.new
    last_tweet.body = client.user_timeline(user_twitter_account.uid.to_i, :count => 1).first.text
    last_tweet.posted_at = client.user_timeline(user_twitter_account.uid.to_i, :count => 1).first.created_at
    last_tweet.provider = "twitter"
    last_tweet
  end

  def get_twitter_client(user)
    user_twitter_account = user.other_accounts.where(provider: "twitter").first
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ResourceProperty.twitter_consumer_key
      config.consumer_secret = ResourceProperty.twitter_consumer_secret
      config.access_token = user_twitter_account.access_token
      config.access_token_secret = user_twitter_account.access_token_secret
    end
    client
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
