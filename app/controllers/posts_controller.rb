class PostsController < ApplicationController
  def index
    @menbers = UserRelationship.find_all follow: @current_user.id
  end

  def show
  end
end
