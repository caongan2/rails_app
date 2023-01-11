module UsersHelper
  def format_name(user)
    if user.gender == 1
      "Mr. #{user.username}"
    else
      "Ms. #{user.username}"
    end
  end
end
