class ForumsController < ApplicationController
	before_action :signed_in_user, only: [:create, :update, :destroy]
	before_action :correct_user, only: [:update, :destroy]

	def new
		@thread = current_user.forums.build if signed_in?
	end

	def create
		@user = User.find(current_user.id)
		@forum = @user.forums.build(forum_params)
		if @forum.save
			flash[:success] = "New thread: #{@forum.topic} created!"
			redirect_to forums_url
		else
			@forum = current_user.forums.build if signed_in? # Comment if want form error
			flash.now[:error] = "Please fill in the new thread topic"
			render 'forum/index'
		end
	end

	def index
		@current_user = current_user
		@threads = Forum.all
	end

	def show
		@thread = Forum.find(params[:id])
	end

	def edit
		@thread = Forum.find(params[:id])
	end

	def update
		@thread = Forum.find(params[:id])
		original_thread_topic = @thread.topic
		if @thread.update_attributes(forum_params)
			flash[:success] = "Thread topic changed '#{original_thread_topic}' to '#{@thread.topic}'"
			redirect_to @thread
		else
			render 'edit'
		end

	end

	def destroy
		thread = Forum.find(params[:id])
		thread_name = thread.destroy
		flash[:success] = "Thread: #{thread.topic} deleted"
		redirect_to forums_url
	end

	private

		def forum_params
  			params.require(:forum).permit(:topic)
  		end

  		def correct_user
  			@thread = Forum.find(params[id])
  			if current_user != @thread.user
  				flash[:warning] = "Do not try to change other user's forums"
  				redirect_to forums_url
  			end
  		end

end
