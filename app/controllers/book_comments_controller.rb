class BookCommentsController < ApplicationController

  def create
  	book_image = BookImage.find(params[:book_image_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_image_id = book_image.id
    comment.save
    redirect_to book_image_path(book_image)
  end

  def destroy
  	BookComment.find_by(id: params[:id], book_image_id: params[:book_image_id]).destroy
    redirect_to book_image_path(params[:book_image_id])
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
