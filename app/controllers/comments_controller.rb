class CommentsController < ApplicationController
  before_filter  :check_already_sign_in
  def new
    @post = Post.where(params[:post_id]).first.comments.build
  end

  def index
    @comments = Comment.where(post_id: params[:post_id])
  end

  def create
    comment = current_user.comments.build(comment_params)
    comment.post_id = params[:post_id]
    comment.save
    redirect_to new_post_comment_path
  end

  private
    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :body)
    end
end
