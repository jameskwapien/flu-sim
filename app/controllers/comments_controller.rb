class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]
  load_and_authorize_resource

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to @post, notice: 'Comment created.' 
    else
      redirect_to @post 
    end
  end

  def show
    redirect_to post_path(@post)
    flash[:alert] = "Comments cannot be shown"
  end

  def update
    if @comment.update(comment_params)
      redirect_to @post, notice: 'Comment edited.' 
    else
      render :edit 
    end
  end

  def destroy
    @comment.destroy
    redirect_to @post, notice: 'Comment deleted.' 
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = @post.comments.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      flash[:alert] = "Oops, it seems this comment doesn't exit."
      redirect_to posts_path
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
end
