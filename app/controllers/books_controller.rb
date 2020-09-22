class BooksController < ApplicationController

	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update, :destroy]

    def show
		@book = Book.find(params[:id])
		@books = Book.all
		@book_new = Book.new
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
		   flash[:success] = "Book was successfully update"
           redirect_to book_path(@book)
        else
        	edit_book_path(@book)
        	render 'edit'
        end
	end

	def destroy
		book = Book.fine(params[:id])
		book.destroy
		redirect_to new_book_path
	end

	def userinfo
		@book = Book.new
	end

	private
	def book_params
		params.require(:book).permit(:title, :body, :image)
	end

	def correct_user
		@book = Book.find(params[:id])
		if current_user.id != @book.user_id
           redirect_to books_path
       end
    end

end
