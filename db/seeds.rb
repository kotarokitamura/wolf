#coding:utf-8

User.create(:uid => 00001, :name => "Taro Tanaka", :first_name => "Taro", :last_name => "Tanaka", :email => "tanaka@example.com")
User.create(:uid => 00002, :name => "Ichiro Yamaguchi", :first_name => "Ichiro", :last_name => "Yamaguchi", :email => "yamaguchi@example.com")
User.create(:uid => 00003, :name => "Sousuke Yoshimoto", :first_name => "Sousuke", :last_name => "Yoshimoto", :email => "yoshimoto@example.com")
User.create(:uid => 00004, :name => "Koichi Ueno", :first_name => "Koichi", :last_name => "Ueno", :email => "ueno@example.com")
User.create(:uid => 00005, :name => "Taichi Yokoya", :first_name => "Taichi", :last_name => "Yokoya", :email => "yokoya@example.com")

OtherAccount.create(:user_id => 1, :provider => "twitter", :uid => 10001, :name => "tarochan", :email => "yokoya@example.com")
OtherAccount.create(:user_id => 2, :provider => "twitter", :uid => 10002, :name => "icchan", :email => "ichi@example.com")
OtherAccount.create(:user_id => 3, :provider => "google", :uid => 20003, :name => "yasshi", :email => "yoshi@example.com")

Post.create(:user_id => 1, :title => "hello", :body => "hello world", :hold_flag => 0)
Post.create(:user_id => 2, :title => "good", :body => "good morning", :hold_flag => 1)
Post.create(:user_id => 3, :title => "veautiful", :body => "vautiful sky", :hold_flag => 1)
Post.create(:user_id => 4, :title => "everything", :body => "everything is ok", :hold_flag => 0)
Post.create(:user_id => 5, :title => "hot", :body => "hot and cold", :hold_flag => 1)

UserRelationship.create(:follower_id => 1, :followed_id => 2)
UserRelationship.create(:follower_id => 1, :followed_id => 3)
UserRelationship.create(:follower_id => 1, :followed_id => 4)
UserRelationship.create(:follower_id => 2, :followed_id => 1)
UserRelationship.create(:follower_id => 2, :followed_id => 5)
UserRelationship.create(:follower_id => 3, :followed_id => 1)
UserRelationship.create(:follower_id => 3, :followed_id => 5)
UserRelationship.create(:follower_id => 3, :followed_id => 4)
UserRelationship.create(:follower_id => 4, :followed_id => 5)
UserRelationship.create(:follower_id => 5, :followed_id => 1)
UserRelationship.create(:follower_id => 5, :followed_id => 2)
