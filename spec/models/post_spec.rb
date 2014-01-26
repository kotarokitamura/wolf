# coding: utf-8
require 'spec_helper'

describe Post do
  fixtures :user_relationships, :users, :posts
  before do
    @post = Post.new
    @post.user_id = 1
    @post.body = 'hello'
    @post.provider = 'wolf'
    @post.hold_flag = 1
    @post.posted_at = '2014-01-21 10:54:37'
  end

  context 'Added posts each pattern' do
    it 'should insert correct pattern in English' do
      @post.body = 'a' * ResourceProperty.post_body_max_length
      @post.save
      Post.last.body.should  == @post.body
    end

    it 'should insert correct pattern in Japanese' do
      @post.body = 'あ' * ResourceProperty.post_body_max_length
      @post.save
      Post.last.body.should  == @post.body
    end

    it 'should return false when insert over max length in English' do
      @post.body = 'a' * ResourceProperty.post_body_max_length + 'a'
      @post.save.should be_false
    end

    it 'should return false when insert over max length in Japanese' do
      @post.body = 'あ' * ResourceProperty.post_body_max_length + 'あ'
      @post.save.should be_false
    end

    it 'should return false when insert user_id nil' do
      @post.user_id = nil
      @post.save.should be_false
    end

    it 'should return false when insert user_id text' do
      @post.user_id = 'a'
      @post.save.should be_false
    end

    it 'should return false when insert hold_flag text' do
      @post.hold_flag = 'a'
      @post.save.should be_false
    end
  end

  context 'Use hold_flag_on?' do
    it 'return true hold flag on' do
      user = User.first
      judge = Post.where(user_id: user.id).first.hold_flag == 1
      @post.hold_flag_on?(user).should == judge
    end

    it 'return false hold flag off' do
      user = User.where(2).first
      judge = Post.where(user_id: user.id).first.hold_flag == 1
      @post.hold_flag_on?(user).should == judge
    end
  end
end
