class AuthorsController < ApplicationController
  def index
    @authors = Author.order("name").page params[:page]
  end

  def show
    @author = Author.find(params[:id])
  end
end
