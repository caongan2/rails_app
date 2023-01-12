class Followe < ApplicationRecord
  belongs_to :user

  def user_username(id)
    @user = User.where(id: id).first
    if @user
      return @user.username
    else
      return "undefine"
    end
  end
end
