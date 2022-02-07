class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
    @comments = BookComment.all
    @book_comment = BookComment.new
  end

  def index
    # ソートリンクをクリックしたときの処理。パラメータが送信されていればソートする。なければ、全てをID順に取得
    if params[:sort].present?
      case params[:sort]
        when "latest"
          @books = Book.all.order(created_at: "DESC")
        when "high_evaluation"
          @books = Book.all.order(evaluation: "DESC")
      end
    else
      @books = Book.all
    end
    @new_book = Book.new
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      redirect_to book_path(@new_book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :evaluation)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    unless @user == current_user
      redirect_to books_path
    end
  end
end
