# coding: utf-8
require 'spec_helper'

describe Comment do
  USER_ID = 1
  POST_ID = 1
  before do
    @comment = Comment.new
    @comment.user_id = USER_ID
    @comment.post_id = POST_ID
    @comment.body = 'a'
  end

  context 'Added comment each body pattern' do
    it 'should insert correct pattern in English' do
      @comment.body = 'a' * ResourceProperty.comment_body_max_length
      @comment.save
      Comment.last.body.should == @comment.body
    end

    it 'should insert correct pattern in Japanese' do
      @comment.body = 'あ' * ResourceProperty.comment_body_max_length
      @comment.save
      Comment.last.body.should == @comment.body
    end

    it 'should return false when body is nil' do
      @comment.body = nil
      @comment.save.should be_false
    end

    it 'should return false when body is nil' do
      @comment.body = ''
      @comment.save.should be_false
    end

    it 'should return false when over max_letters in Japanese' do
      @comment.body = 'あ' * ResourceProperty.comment_body_max_length + 'あ'
      @comment.save.should be_false
    end

    it 'should return false when over max_letters in English' do
      @comment.body = 'a' * ResourceProperty.comment_body_max_length + 'a'
      @comment.save.should be_false
    end
  end

  context 'Added comment each reference id pattern' do
    it 'should return true when post_id exist' do
      @comment.post_id = POST_ID
      @comment.save
      Comment.last.post_id.should == @comment.post_id
    end

    it 'should return false when post_id nil' do
      @comment.post_id = nil
      @comment.save.should be_false
    end

    it 'should return false when post_id nil' do
      @comment.post_id = ''
      @comment.save.should be_false
    end

    it 'should return false when post_id char' do
      @comment.post_id = 'a'
      @comment.save.should be_false
    end

    it 'should return true when user_id exist' do
      @comment.user_id = USER_ID
      @comment.save
      Comment.last.user.should == @comment.user
    end

    it 'should return false when user_id nil' do
      @comment.user_id = nil
      @comment.save.should be_false
    end

    it 'should return false when user_id nil' do
      @comment.user_id = ''
      @comment.save.should be_false
    end

    it 'should return false when user_id char' do
      @comment.user_id = 'a'
      @comment.save.should be_false
    end
  end
end
