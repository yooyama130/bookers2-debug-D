class SearchesController < ApplicationController
  def search
    # 1.viewのリスト選択プルダウンから、モデル取得（paramsはstring値しか取らないため）
    @list_name =params[:list]
    @searches =Book.all if @list_name == "Book"
    @searches =User.all if @list_name == "User"
    # 2.params[:search]（入力された値）を受けとり、検索手法のプルダウンの値により、
    @search = params[:search]
    if params[:how_to_search] == "完全一致"
      if (@list_name == "Book") && (params[:search].present?)
        @searches = @searches.where('title LIKE ?', params[:search])
      end
      if (@list_name == "User") && (params[:search].present?)
        @searches = @searches.where('name LIKE ?', params[:search])
      end
    end
    if params[:how_to_search] == "前方一致"
      if (@list_name == "Book") && (params[:search].present?)
        @searches = @searches.where('title LIKE ?', "#{params[:search]}%")
      end
      if (@list_name == "User") && (params[:search].present?)
        @searches = @searches.where('name LIKE ?', "#{params[:search]}%")
      end
    end
    if params[:how_to_search] == "後方一致"
      if (@list_name == "Book") && (params[:search].present?)
        @searches = @searches.where('title LIKE ?', "%#{params[:search]}")
      end
      if (@list_name == "User") && (params[:search].present?)
        @searches = @searches.where('name LIKE ?', "%#{params[:search]}")
      end
    end
    if params[:how_to_search] == "部分一致"
      if (@list_name == "Book") && (params[:search].present?)
        @searches = @searches.where('title LIKE ?', "%#{params[:search]}%")
      end
      if (@list_name == "User") && (params[:search].present?)
        @searches = @searches.where('name LIKE ?', "%#{params[:search]}%")
      end
    end
  end


end
