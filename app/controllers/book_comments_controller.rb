class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book)
  end

  def destroy
    @comment = Book.find(params[:book_id])
    comment = @comment.book_comments.find(params[:id])
    if current_user.id == comment.user.id
    comment.destroy
    redirect_back(fallback_location: root_path)
    else
      render "books/show"
    end
  end

  def book_comment_params
      params.require(:book_comment).permit(:comment)
  end


end
