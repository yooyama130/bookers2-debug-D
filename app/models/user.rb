class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # フォローをした、されたの関係
  has_many :followed, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy、
  # そのユーザがフォローしている人orフォローされている人の一覧を出したい
  has_many :followings, through: :followed, source: :followed
  has_many :followers, through: :follower, source: :follower

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
end
