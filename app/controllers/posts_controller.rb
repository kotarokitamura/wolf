class PostsController < ApplicationController
  def show
    contents = (Post.find_by user_id: current_user.id) || Post.new
    contents.save_latest_contents(current_user)
    @post = Post.find(params[:id])
  end
end
