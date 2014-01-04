class PostsController < ApplicationController
  def show
    # 現ユーザーの最新のコンテンツを取得
    # Get latest content of own user
    @contents = (Post.find_by user_id: current_user.id) || Post.new
    @contents.save_latest_contents(current_user)
    #get :post_id contents
    @post = Post.find(params[:id])
  end

  private
  def post_params
  end
end
