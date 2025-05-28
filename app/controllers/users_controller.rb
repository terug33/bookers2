class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all 
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new 
  end

  def edit
  end
end
