class PostsController < ApplicationController
  def show
    #get information from facebook
    graph = Koala::Facebook::API.new(current_user.access_token)
    @contents = graph.get_connections("me", "feed", :limit => 5)
  end
end
