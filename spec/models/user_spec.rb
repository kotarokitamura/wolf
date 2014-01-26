# coding: utf-8
require 'spec_helper'

describe User do
  fixtures :user_relationships,:users,:posts

  before do
    @user = User.new
    @user.name = 'Hoge Fuga'
    @user.uid = '100007112803237'
    @user.first_name = 'Hoge'
    @user.last_name = 'Fuga'
  end

  context 'Insert user_relationships in some situations' do
    it 'should return true correct user_relationship data' do
      @user.save
      User.last.uid.should == @user.uid
    end

    it 'should return false when uid nil' do
      @user.uid = nil
      @user.save.should be_false
    end

    it 'should return false when name nil' do
      @user.name = nil
      @user.save.should be_false
    end

    it 'should return false when name over_max_length' do
      @user.name = 'a' * ResourceProperty.name_max_length + 'a'
      @user.save.should be_false
    end

    it 'should return true when name under_max_length' do
      @user.name = 'a' * ResourceProperty.name_max_length
      @user.save
      User.last.uid.should == @user.uid
    end
  end

  context 'Using some method in User' do
    it 'return all following users' do
      current_user = User.first
      following_users = User.get_following_users(current_user).first
      following_users_mathcer = UserRelationship.where(user_id: current_user.id).first
      following_users.should == following_users
    end

    it 'return correct following flag' do
      current_user = User.first
      you = User.where(2).first
      following_flag = you.get_followed_flag(current_user)
      following_flag_matcher = UserRelationship.where(["user_id = ? and followed_id = ?", current_user.id, you.id]).first.nil? ? 0 : 1
      following_flag.should == following_flag_matcher
    end
  end
end
