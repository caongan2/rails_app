class Followe < ApplicationRecord
  belongs_to :user

  def user_username(id)
    User.find(id).username
  end
end
