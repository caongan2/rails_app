class Post < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  belongs_to :user
  delegate :username, to: :user, prefix: true, allow_nil: true
  delegate :avatar, to: :user, prefix: true, allow_nil: true
end
