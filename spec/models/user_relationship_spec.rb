# coding: utf-8
require 'spec_helper'

describe UserRelationship do
  fixtures :user_relationships,:users,:posts

  before do
    @user_relationship = UserRelationship.new
    @user_relationship.user_id = 1
    @user_relationship.followed_id = 2
    @user_relationship.last_checked_at = '2014-01-20 14:16:53'
  end

  context 'Insert user_relationships in some situations' do
    it 'should return true correct user_relationship data' do
      @user_relationship.save
      UserRelationship.last.last_checked_at.should == @user_relationship.last_checked_at
    end

    it 'should return false when user_id nil' do
      @user_relationship.user_id = nil
      @user_relationship.save.should be_false
    end

    it 'should return false when user_id except number' do
      @user_relationship.user_id = 'a'
      @user_relationship.save.should be_false
    end

    it 'should return false when followed_id nil' do
      @user_relationship.followed_id = nil
      @user_relationship.save.should be_false
    end

    it 'should return false when followed_id except number' do
      @user_relationship.followed_id = 'a'
      @user_relationship.save.should be_false
    end
  end

  context 'using some original methods' do
    it 'should be return true when update_last_checked_time' do
      old_user_relationship = UserRelationship.first
      old_last_checked_at = old_user_relationship.last_checked_at
      old_user_relationship.update_last_checked_time
      new_user_relationship = UserRelationship.first
      (new_user_relationship.last_checked_at > old_last_checked_at).should be_true
    end

    it 'should be return true already_checked' do
      current_user = User.first
      checked_user = User.last
      current_user.user_relationships.where(followed_id: checked_user.id).first.already_check?(checked_user).should be_false
    end

    it 'should be return false already_checked' do
      current_user = User.last
      checked_user = User.first
      current_user.user_relationships.where(followed_id: checked_user.id).first.already_check?(checked_user).should be_true
    end

    it 'should be return true get_relationship' do
      params = {:id => User.last.id}
      current_user = User.first
      (UserRelationship.get_relationship(current_user,params).id == UserRelationship.where(["user_id = ? and followed_id = ?", current_user.id, params[:id]]).first.id).should be_true
    end
  end

  context 'Using count_all_follower' do
    it 'should be return correct count' do
      user = User.first
      UserRelationship.count_all_follower(user).should == UserRelationship.where(followed_id: user.id).count
    end
  end
end
