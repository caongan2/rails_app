class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, PictureUploader
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :followers, dependent: :destroy
  has_many :spending_plans, dependent: :destroy
end
