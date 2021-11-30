class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    if @book_comment.save
      @book = Book.find(params[:book_id])
      @user = @book.user
      @new_book = Book.new
      @comments = BookComment.all
      @book_comment = BookComment.new
      # redirect_to book_path(@book)
    else
      @comments = BookComment.all
      @user = @book.user
       @new_book = Book.find(params[:book_id])
      # render 'books/show'
    end
  end

  def destroy
    comment = BookComment.find(params[:id])
    comment.destroy
    @book = Book.find(params[:book_id])
    @user = @book.user
    @new_book = Book.new
    @comments = BookComment.all
    @book_comment = BookComment.new
    # redirect_to book_path(params[:book_id])
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
