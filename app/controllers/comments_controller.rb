class CommentsController < ApplicationController
  
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = params[:post_id]
    flash[:errors] = @comment.errors.full_messages unless @comment.save
    redirect_to post_url(@comment.post)
  end
  
  def update
  end
  
  def destroy
  end
  
  def upvote
    vote(1)
  end
  
  def downvote
    vote(-1)
  end

  private
  
  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id, :post_id)
  end
  
  def vote(value)
    @comment = Comment.find(params[:id])
    @vote = @comment.votes.build(
      value: value, votable_id: params[:id], 
      votable_type: @comment.class.name
    )
    
    @vote.save
    redirect_to post_url(@comment.post)
  end
  
end
