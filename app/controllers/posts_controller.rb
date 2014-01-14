class PostsController < ApplicationController
  def show
    user_relationship = current_user.user_relationships.where(followed_id: params[:id]).first
    user_relationship.update_last_checked_time unless user_relationship.nil?

    contents = (Post.find_by user_id: current_user.id) || Post.new
    contents.save_latest_contents(current_user)
    @post = Post.find(params[:id])
    render 'own_post' if @post.user_id == current_user.id
  end

  def new
    @post = current_user.posts.build
  end

  def create
    post = current_user.posts.build(post_params)
    post.provider = "wolf"
    post.posted_at = Time.now
    old_post = Post.where(user_id: post.user_id).first
    old_post.nil? ? post.save : old_post.update_attributes(title: post.title, body: post.body, provider: post.provider, hold_flag: post.hold_flag)

    redirect_to new_post_path
  end

  def update
    post = Post.where(user_id: current_user.id).first
    new_post = Post.new(post_params)
    post.update_attributes( hold_flag: new_post.hold_flag )
    redirect_to post_path
  end


  private
    def post_params
      params.require(:post).permit(:body, :title, :user_id, :hold_flag)
    end
end
