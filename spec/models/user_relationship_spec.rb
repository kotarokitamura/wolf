# coding: utf-8
require 'spec_helper'

describe UserRelationship do
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
end
