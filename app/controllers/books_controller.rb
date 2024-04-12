class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
    @publishers = Publisher.all.ordered_by_name
    @authors = Author.all.ordered_by_last_name
  end

  def create
    @book = Book.new(book_params)
    author = Author.find(params[:author])
    @book.authors << author

    if @book.save!
      redirect_to @book
    else
      @publishers = Publisher.all.ordered_by_name
      @authors = Author.all.ordered_by_last_name
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :isbn_13, :list_price, :publication_year, :publisher_id, :edition)
  end
end
