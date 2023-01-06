class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  delegate :username, to: :user, prefix: true, allow_nil: true
  delegate :avatar, to: :user, prefix: true, allow_nil: true
end
