class PostsController < ApplicationController
  def index
    @auth = current_user
    @posts = Post.order('id DESC')
  end

  def create
    @post = Post.new(post_data)
    if @post.save
      redirect_back(fallback_location: '')
    end
  end

  private
  def post_data
    params.permit(:content, :user_id, :image)
  end
end
