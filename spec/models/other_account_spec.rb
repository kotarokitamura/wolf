# coding: utf-8
require 'spec_helper'

describe OtherAccount do
  fixtures :users,:other_accounts
  before do
    @other_account = OtherAccount.new
    @other_account
  end

  context 'Added OtherAccount with some pattern' do
    it 'should insert correct pattern' do
    end
  end
end
