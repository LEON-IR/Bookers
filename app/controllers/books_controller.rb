class BooksController < ApplicationController

	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update, :destroy]

    def show
		@book = Book.find(params[:id])
		@user = @book.user
		@books = Book.all
		@book_new = Book.new
		@book_comments = @book.book_comments
		@book_comment = BookComment.new
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if@book.save
			flash[:success] = "You have created book successfully."
			redirect_to book_path(@book.id)
		else
			@books = Book.all
			render 'index'
		end
	end

	def index
		@books = Book.all
		@book = Book.new
	end

	def edit
		@book = Book.find(params[:id])
		@book_edit = Book.new
	end

	def update
		@book = Book.find(params[:id])
		if@book.update(book_params)
		   flash[:success] = "You have updated book successfully."
           redirect_to book_path(@book)
        else
        	edit_book_path(@book)
        	render 'edit'
        end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end

	def userinfo
		@book = Book.new
	end

	private
	def book_params
		params.require(:book).permit(:title, :body, :image, :user_id)
	end

	def correct_user
		@book = Book.find(params[:id])
		if current_user.id != @book.user_id
           redirect_to books_path
       end
    end

end
