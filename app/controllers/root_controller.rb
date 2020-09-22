class RootController < ApplicationController

	def top
		@book = Book.new
	end

end
