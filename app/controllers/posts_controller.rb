class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	load_and_authorize_resource

	def index	
		@posts = Post.all.order("created_at DESC")
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)

		if @post.save
			redirect_to @post, notice: "Post created."
		else
			render 'new'
		end
	end

	def update
		if @post.update(post_params)
			redirect_to @post, notice: "Post edited."
		else
			render 'edit'
		end
	end


	def destroy
		@post.destroy
		respond_to do |format|
		  format.js {render inline: "location.reload();" }
		end
		flash[:notice] = "Post deleted."
	end

	private
	def find_post
		@post = Post.find(params[:id])
	rescue ActiveRecord::RecordNotFound => e
  		flash[:alert] = "Oops, it seems this post doesn't exit."
  		redirect_to action: :index
	end

	def post_params
		params.require(:post).permit(:title, :content)
	end
end
