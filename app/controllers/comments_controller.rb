class CommentsController < ApplicationController
  before_filter  :check_already_sign_in
  def create
    comment = current_user.comments.build(comment_params)
    comment.post_id = params[:post_id]
    comment.save
    redirect_to :controller => 'posts',:action => 'show',:id => comment.post_id
  end

  private
    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :body)
    end
end
