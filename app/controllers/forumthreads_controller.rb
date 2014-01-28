class ForumthreadsController < ApplicationController
	before_action :signed_in_user, only: [:create, :update, :destroy]
	before_action :correct_user, only: [:update, :destroy]

	def new
		@thread = current_user.forumthreads.build if signed_in?
	end

	def create
		@user = User.find(current_user.id)
		@thread = @user.forumthreads.build(thread_params)
		if @thread.save
			flash[:success] = "New thread: #{@thread.topic} created!"
			redirect_to forumthreads_url
		else
			@thread = current_user.forumthreads.build if signed_in? # Comment if want form error
			flash.now[:error] = "Please fill in the new thread topic"
			render 'thread/index'
		end
	end

	def index
		@current_user = current_user
		@threads = Forumthread.all
	end

	def show
		@thread = Forumthread.find(params[:id])
	end

	def edit
		@thread = Forumthread.find(params[:id])
	end

	def update
		@thread = Forumthread.find(params[:id])
		original_thread_topic = @thread.topic
		if @thread.update_attributes(thread_params)
			flash[:success] = "Forumthread topic changed '#{original_thread_topic}' to '#{@thread.topic}'"
			redirect_to @thread
		else
			render 'edit'
		end

	end

	def destroy
		thread = Forumthread.find(params[:id])
		thread_name = thread.destroy
		flash[:success] = "Forumthread: #{thread.topic} deleted"
		redirect_to forumthreads_url
	end

	private

		def thread_params
  			params.require(:forumthread).permit(:topic)
  		end

  		def correct_user
  			@thread = Forumthread.find(params[:id])
  			if current_user != @thread.user
  				flash[:warning] = "Do not try to change other user's threads"
  				redirect_to forumthreads_url
  			end
  		end

end
