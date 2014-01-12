class PostsController < ApplicationController
  def show
    # 現ユーザーの最新のコンテンツを取得、保存
    # Get latest content and save of own user
    contents = (Post.find_by user_id: current_user.id) || Post.new
    contents.save_latest_contents(current_user)
    # 特定のユーザーのコンテンツを取得
    # get :post_id contents
    @post = Post.find(params[:id])
  end
end
