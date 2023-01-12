module UsersHelper
  def format_name(user)
    if user.gender == 1
      "Mr. #{user.username}"
    else
      "Ms. #{user.username}"
    end
  end

  def is_followed?(user)
    if user
      Followe.where(user_id: user.id, follower: current_user.id, followed: 1).first
    end
  end

  def user(id)
    User.where(id: id).first
  end
end
