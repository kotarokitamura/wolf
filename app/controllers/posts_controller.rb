class PostsController < ApplicationController
  def show
    user_relationship = current_user.user_relationships.where(followed_id: params[:id]).first
    user_relationship.update_last_checked_time unless user_relationship.nil?

    contents = (Post.find_by user_id: current_user.id) || Post.new
    contents.save_latest_contents(current_user)
    @post = Post.find(params[:id])
  end
end
