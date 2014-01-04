class Post < ActiveRecord::Base
  belongs_to :user

  def save_latest_contents(current_user)
    get_facebook_contents(current_user)
  end

  def get_facebook_contents(current_user)
    # アクセストークンを利用して、APIで接続
    # the first step is get only latest post
    graph = Koala::Facebook::API.new(current_user.access_token)

    # ログインユーザーのフィードの情報を取得
    # To get the current user's latest content
    contents = graph.get_connections("me", "feed")

    # 最新順にソートを変更する
    # sourt new
    contents.sort!{ |a, b| b[:updated_time] <=> a[:updated_time] }
    contents.each do |content|
      next unless content.keys.include?("message")
      self.user_id = current_user.id
      self.body = content["message"]
      self.posted_at = content["updated_time"]
      break
    end

    # ログインユーザーのポストがすでにあるかどうかで、保存と上書きを変更
    # Check the current user's old post if not exist save
    Post.exists?(user_id: current_user.id).nil? ? self.save : self.update(user_id: current_user.id)
  end
end
