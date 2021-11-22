class SearchesController < ApplicationController
  def search
    # 1.viewのリスト選択プルダウンから、名前だけ受け取る
    @model_name =params[:model_name]
    # 2.params[:search]（入力された値）と検索手法のプルダウンの値を受け取り、modelクラスに記述したメソッドを使用
    @search = params[:search]
    @how_to_search = params[:how_to_search]
		if @model_name == 'User'
			@searches = User.search_for(@search, @how_to_search)
		elsif @model_name == 'Book'
			@searches = Book.search_for(@search, @how_to_search)
		end
  end


end
