class PostsController < ApplicationController
  def index
    @posts = Post.order('id DESC')
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_back(fallback_location: "")
  end

  def show
    @user = current_user
    @post = Post.find_by(params[:id])
  end

  def create
    @post = Post.new(data)
    @user = current_user
    UserMailer.with(user: @user).welcome_email.deliver_now
    @post.image.attach(params[:image])
    if @post.save
      redirect_back(fallback_location: "")
    end
  end

  private
  def data
    params.require('post').permit(:content, :user_id, :image)
  end
end
