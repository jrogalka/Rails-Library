class PagesController < ApplicationController
  def index
    @books = Book.all
  end

  def about; end
end
