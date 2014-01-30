class ThreadpostsController < ApplicationController
	before_action :signed_in_user, only: [:create, :update, :destroy]
	before_action :correct_user, only: [:update, :destroy]

	def new
		@thread = current_user.threadposts.build if signed_in?
	end

	def create
		@user = User.find(current_user.id)
		@thread = @user.threadposts.build(thread_params)
		if @thread.save
			flash[:success] = "New thread: #{@thread.topic} created!"
			redirect_to threadposts_url
		else
			@thread = current_user.threadposts.build if signed_in? # Comment if want form error
			flash.now[:danger] = "Please fill in the new thread topic"
			render 'thread/index'
		end
	end

	def index
		@current_user = current_user
		@threads = Threadpost.all
	end

	def show
		@thread = Threadpost.find(params[:id])
		@comment = @thread.comments.build if signed_in?
	end

	def edit
		@thread = Threadpost.find(params[:id])
	end

	def update
		@thread = Threadpost.find(params[:id])
		original_thread_topic = @thread.topic
		if @thread.update_attributes(thread_params)
			flash[:success] = "Threadpost topic changed '#{original_thread_topic}' to '#{@thread.topic}'"
			redirect_to @thread
		else
			render 'edit'
		end

	end

	def destroy
		thread = Threadpost.find(params[:id])
		thread_temp = thread.destroy
		flash[:success] = "Threadpost: '#{thread_temp.topic}' deleted"
		redirect_to threadposts_url
	end

	private

		def thread_params
  			params.require(:threadpost).permit(:topic)
  		end

  		def correct_user
  			@thread = Threadpost.find(params[:id])
  			if current_user != @thread.user
  				flash[:warning] = "Do not try to change other user's threads"
  				redirect_to threadposts_url
  			end
  		end

end
