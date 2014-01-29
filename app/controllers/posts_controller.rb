class PostsController < ApplicationController
  before_filter  :check_already_sign_in
  def show
    raise ForbiddenError if User.where(id: params[:id]).first.nil?
    user_relationship = current_user.user_relationships.where(followed_id: params[:id]).first
    user_relationship.update_last_checked_time unless user_relationship.nil?
    content = (Post.find_by id: params[:id]) || User.where(id: current_user.id).first.posts.build
    content.save_latest_contents(content.user)
    @post = Post.where(id: params[:id]).first
    @comments = @post.comments
    @comment = @post.comments.build

    @checked_count = @post.count_post_checked_user if @post.user_id == current_user.id
    @all_follower = UserRelationship.count_all_follower(current_user) if @post.user_id == current_user.id

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
    old_post.nil? ? post.save : old_post.update_attributes( body: post.body, provider: post.provider, hold_flag: post.hold_flag, posted_at: post.posted_at)
    Comment.destroy_all(post_id: old_post.id) unless old_post.nil?
    new_post = Post.where(user_id: post.user_id).first
    redirect_to controller: "posts", action: "show", id: new_post.id
  end

  def update
    post = Post.where(user_id: current_user.id).first
    new_post = Post.new(post_params)
    post.update_attributes( hold_flag: new_post.hold_flag )
    redirect_to post_path
  end

  private
    def post_params
      params.require(:post).permit(:body, :user_id, :hold_flag)
    end
end
