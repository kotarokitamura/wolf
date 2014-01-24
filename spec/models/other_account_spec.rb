# coding: utf-8
require 'spec_helper'

describe OtherAccount do
  fixtures :users,:other_accounts
  before do
    @other_account = OtherAccount.new
    @other_account.user_id = 1
    @other_account.provider = 'twitter'
    @other_account.uid = '123456'
    @other_account.name = 'Taro Yamada'
    @other_account.email = 'taro.yamada@example.com'
  end

  context 'Added OtherAccount with some pattern' do
    it 'should return true when insert correct pattern' do
      @other_account.save
      OtherAccount.last.uid.should == @other_account.uid
    end

    it 'should return false when insert name over max_length' do
      @other_account.name = 'a' * ResourceProperty.name_max_length + 'a'
      @other_account.save.should  be_false
    end

    it 'should return false when insert email over max_length' do
      @other_account.name = 'a' * ResourceProperty.email_max_length + 'a'
      @other_account.save.should  be_false
    end

    it 'should return false when insert uid nil' do
      @other_account.uid = nil
      @other_account.save.should  be_false
    end

    it 'should return false when insert user_id nil' do
      @other_account.user_id = nil
      @other_account.save.should  be_false
    end
  end
end
