class CommentsController < ApplicationController
	before_action :signed_in_user, only: [:create, :update, :destroy]

	def new
		
	end

	def create
		@thread = Threadpost.find(params[:thread_id])
		@comment = @thread.comments.build(comment_params)
		@comment.user_id = params[:user_id]
		if @comment.save
			flash[:success] = "Comment success!"
			redirect_to @thread
		else
			@comment = current_user.comments.build if signed_in?# Comment if want form error
			flash[:danger] = "Please fill in the comment content"
			redirect_to @thread
		end
	end

	def index

	end

	def show
		@comment = Comment.find(params[:id])
	end

	def edit
		@comment = Comment.find(params[:id])
		@thread = @comment.threadpost
	end

	def update
		@comment = Comment.find(params[:id])
		if @comment.update_attributes(comment_params)
			flash[:success] = "Comment changed"
			redirect_to @comment.threadpost
		else
			render 'edit'
		end
	end

	def destroy
		comment = Comment.find(params[:id])
		comment.destroy
		flash[:success] = "Comment deleted"
		redirect_to comment.threadpost
	end

	private

		def comment_params
  			params.require(:comment).permit(:content)
  		end

end
