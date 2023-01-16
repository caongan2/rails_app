class Post < ApplicationRecord
  mount_uploader :picture, PictureUploader

  belongs_to :user
  delegate :username, to: :user, prefix: true, allow_nil: true
  delegate :avatar, to: :user, prefix: true, allow_nil: true
end
