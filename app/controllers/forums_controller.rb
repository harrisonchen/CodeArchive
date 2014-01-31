class ForumsController < ApplicationController

	def new
		@forum = Forum.new
	end

	def create
		@forum = Forum.new(forum_params)
		if @forum.save
			flash[:success] = "Forum: #{@forum.category} created!"
			redirect_to @forum
		else
			@forum = Forum.new# Comment if want form error
			flash[:danger] = "Please fill in the forum category"
			render 'new'
		end
	end

	def edit
		@forum = Forum.find(params[:id])
	end

	def update
		@forum = Forum.find(params[:id])
		original_forum_category = @forum.category
		if @forum.update_attributes(forum_params)
			flash[:success] = "Forum category changed '#{original_forum_category}' to '#{@forum.category}'"
			redirect_to @forum
		else
			render 'edit'
		end
	end

	def index
		@forums = Forum.all
	end

	def show
		@forum = Forum.find(params[:id])
	end

	def destroy
		forum = Forum.find(params[:id])
		forum_destroyed = forum.destroy
		flash[:success] = "Forum: #{forum_destroyed.category} deleted"
		redirect_to forums_url
	end

	private

		def forum_params
  			params.require(:forum).permit(:category)
  		end

end
