class BooksController < ApplicationController
  
  def index
    @books = Book.all
    @user = current_user
  end
  
  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    book.save
    redirect_to user_path(book.user_id)
  end
  
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
