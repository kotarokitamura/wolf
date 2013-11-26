class PostsController < ApplicationController
  def show
    #get information from facebook
    graph = Koala::Facebook::API.new(current_user.access_token)
    me = graph.get_object("me")
  end
end
