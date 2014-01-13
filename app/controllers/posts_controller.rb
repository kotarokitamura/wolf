class PostsController < ApplicationController
  def show
    debugger
    user_relationship = current_user.user_relationships.where(["follower_id = ? and followed_id = ?", current_user.id, params[:id]]).first
    user_relationship.update_last_checked_time

    contents = (Post.find_by user_id: current_user.id) || Post.new
    contents.save_latest_contents(current_user)
    @post = Post.find(params[:id])
  end
end
