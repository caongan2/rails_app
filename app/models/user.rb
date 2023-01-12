class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :followes, dependent: :destroy
  has_many :messages
  has_many :rooms

end
