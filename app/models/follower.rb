class Follower < ApplicationRecord
  belongs_to :user

  def user_username(id)
    @user = User.where(id: id).first
    if @user
      @user.username
    else
      "undefine"
    end
  end
end
