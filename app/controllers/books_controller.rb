class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @books= Book.all
    @book= Book.new
    @user= current_user
  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new 
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
      @books = Book.all
      render :index
    end 
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.user == current_user
      @book.destroy
      flash[:notice] = "Successfully deleted"
    else
      flash[:alert] ="You tried to delete a book but got an error"
    end
    redirect_to books_path 
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end 

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      flash[:alert] = "error"
      redirect_to books_path
    end
  end

end
