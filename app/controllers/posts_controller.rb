class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	load_and_authorize_resource

	def index	
		@posts = Post.all.order("created_at DESC")
	end

	def new
		@post = current_user.posts.build
	end

	def update
		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end
	end

	def create
		@post = current_user.posts.build(post_params)

		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def destroy
		@post.destroy
		redirect_to :action => 'index'
	end

	private
	def find_post
		@post = Post.find(params[:id])
	rescue ActiveRecord::RecordNotFound => e
  		flash[:notice] = "Oops, it seems this object doesn't exit."
  		redirect_to action: :index
	end

	def post_params
		params.require(:post).permit(:title, :content)
	end
end
