class Book < ApplicationRecord

	belongs_to :user
	attachment :image
	has_many :book_comments, dependent: :destroy

end
