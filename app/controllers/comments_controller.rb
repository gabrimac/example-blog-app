class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(username: params[:comment][:username], comment: params[:comment][:comment], post_id: @post.id)
    respond_to do |format|
      if @comment.save
        format.js
      else
        format.js {render 'error_create'}
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.js
    end
  end

end
