class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books= Book.all
    @book= Book.new
    @user= current_user
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else 
      flash.now[:alert] = "There was an error creating the book."
      @user = current_user
      render 'users/show'
    end 
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end 

end
