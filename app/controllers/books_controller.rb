class BooksController < ApplicationController
  def index
    @books = Book.includes(:author).order("rating DESC").page params[:page]
  end

  def show
    @book = Book.find(params[:id])
  end
end
