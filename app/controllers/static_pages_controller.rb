class StaticPagesController < ApplicationController
	def home
		@threads = Threadpost.all
	end

	def help
	end

	def contact
	end
end