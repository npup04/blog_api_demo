class CommentsController < ApplicationController
  def index
    if params[:post_id]
      @post = Post.find(params[:post_id])
      @comments = @post.comments
      render json: @comments, status: 200
    else
      @comments = Comment.all
      render json: @comments, status: 200
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @post.comments << @comment
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      render json: @comment, status: 200
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    head :no_content
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :author)
  end

end
