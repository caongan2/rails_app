class PostsController < ApplicationController
  def index
    @posts = Post.order('id DESC')
  end

  def create
    @post = Post.new(post_data)
    if @post.save
      redirect_to action: 'index'
    end
  end

  private
  def post_data
    params.permit(:content, :user_id, :image)
  end
end
