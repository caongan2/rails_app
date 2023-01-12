class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @followes = Followe.where(user_id: @user.id, followed: 1).count
    @follow = Followe.where(user_id: params[:id], follower: current_user.id).first
    if @follow
      @followed = @follow.followed
    else
      @followed = 0
    end
    @posts = Post.where(user_id: @user.id).order('id DESC')
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_back(fallback_location: "")
    end
  end

  def follow_to
    @user = current_user
    @followes = Followe.where(follower: @user.id)
  end

  def index
    @users = User.all
  end
end
