class ChangeBookImagesToBooks < ActiveRecord::Migration[5.2]
  def change
  	rename_table :book_images, :books
  end
end
