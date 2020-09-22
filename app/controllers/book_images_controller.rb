class BookImagesController < ApplicationController

  def new
  	@book_image = BookImage.new
  end

  def create
  	@book_image = BookImage.new(book_image_params)
    @book_image.user_id = current_user.id
    @book_image.save
    redirect_to book_images_path
  end

  def index
  	 @book_images = BookImage.all
  end

  def show
  	 @book_image = BookImage.find(params[:id])
     @book_comment = BookComment.new
  end

  private
  def book_image_params
    params.require(:book_image).permit(:image, :title, :opinion)
  end

end
