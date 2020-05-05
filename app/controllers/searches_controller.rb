class SearchesController < ApplicationController
  def search
    @user_or_book = params[:option]
    if @user_or_book == "1"
      @users = User.search(params[:search], @user_or_book)
    else
      @books = Book.search(params[:search], @user_or_book)
    end

    @book = Book.new
  end
end
