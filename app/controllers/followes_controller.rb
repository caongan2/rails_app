class FollowesController < ApplicationController

  def index
    @user = current_user
    @followes = Followe.where(user_id: @user.id)
  end

  def follow
    @follow = Followe.where(user_id: params[:user_id], follower: current_user.id).first
    if @follow
      is_fl = @follow.followed
      if is_fl == 1
        @follow.update(followed: 0)
        render json: {
          message: "ok"
        }
      else
        @follow.update(followed: 1)
        render json: {
          message: "ok"
        }
      end
    else
      @follow = Followe.new(data)
      if @follow.save
        render json: {
          message: "ok"
        }
      else
        render json: {
          message: "miss"
        }
      end
    end
    end

  private
  def data
    params.permit(:user_id, :follower)
  end
end
