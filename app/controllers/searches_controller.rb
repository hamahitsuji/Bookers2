class SearchesController < ApplicationController
  def search
    @user_or_book = params[:option]
    @how_search = params[:choice]

    @users = User.search(params[:search], @how_search)
    @books = Book.search(params[:search], @how_search)

    @book = Book.new
  end
end
