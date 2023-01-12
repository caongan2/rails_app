class PostsController < ApplicationController
  def index
    @posts = Post.order('id DESC')
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      render json: {
        message: "destroy success"
      }
    else
      render json: {
        message: "destroy failed"
      }
    end
  end

  def show
    @user = current_user
    @post = Post.find_by(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(data_update)

    redirect_back(fallback_location: "")
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
    params.require('post').permit(:content, :user_id)
  end

  def data_update
    params.require('post').permit(:content, :image)
  end
end
