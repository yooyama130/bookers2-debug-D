class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  #検索する
  def self.search_for(search, how_to_search)
    if how_to_search == '完全一致'
      Book.where(title: search)
    elsif how_to_search == '前方一致'
      Book.where('title LIKE ?', search + '%')
    elsif how_to_search == '後方一致'
      Book.where('title LIKE ?', '%' + search)
    else
      Book.where('title LIKE ?', '%' + search + '%')
    end
  end


	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
