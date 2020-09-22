class UsersController < ApplicationController

	before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def index
  	@users = User.all
  	@book = Book.new
  end

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  	  redirect_to user_path(@user)
  	  flash[:success] = "You have updated user successfully."
  	else
  		render 'edit'
  	end
  end

  def userinfo
  	 @user = User.find(current_user.id)
  end

  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
    @user = User.find(params[:id])
    if current_user.id != @user.id
        redirect_to user_path(current_user.id)
    end
  end


end
