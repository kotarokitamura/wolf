# coding: utf-8
require 'spec_helper'

describe Comment do
  USER_ID = 1
  POST_ID = 1
  before do
    @comment = Comment.new
    @comment.user_id = USER_ID
    @comment.post_id = POST_ID
  end

  context 'Added comment correct pattern' do
    it 'should insert correct pattern in English' do
      @comment.body = 'a' * ResourceProperty.comment_max_length
      @comment.save
      Comment.last.body.should == @comment.body
    end

    it 'should insert correct pattern in Japanese' do
      @comment.body = 'あ' * ResourceProperty.comment_max_length
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
      @comment.body = 'あ' * ResourceProperty.comment_max_length + 'あ'
      @comment.save.should be_false
    end

    it 'should return false when over max_letters in English' do
      @comment.body = 'a' * ResourceProperty.comment_max_length + 'a'
      @comment.save.should be_false
    end
  end
end
