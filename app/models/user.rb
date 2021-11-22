class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # フォローをした、されたの関係
  has_many :relationships_with_followings, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :relationships_with_followers, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # そのユーザがフォローしている人orフォローされている人の一覧を出したい
  has_many :followings, through: :relationships_with_followings, source: :followed
  has_many :followers, through: :relationships_with_followers, source: :follower

 # フォローしたときの処理
 def follow(user_id)
    relationships_with_followings.create(followed_id: user_id)
 end
 # フォローを外すときの処理
 def unfollow(user_id)
    relationships_with_followings.find_by(followed_id: user_id).destroy
 end
 # フォローしているか判定
 def following?(user)
    followings.include?(user)
 end

  #検索する
  def self.search_for(search, how_to_search)
    if how_to_search == '完全一致'
      User.where(name: search)
    elsif how_to_searchmethod == '前方一致'
      User.where('name LIKE ?', search + '%')
    elsif how_to_search == '後方一致'
      User.where('name LIKE ?', '%' + search)
    else
      User.where('name LIKE ?', '%' + search + '%')
    end
  end


  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
end
