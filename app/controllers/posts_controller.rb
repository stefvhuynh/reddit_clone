class PostsController < ApplicationController
  
  def show
    @post = Post.find(params[:id])
    @comments_by_parent_id = @post.comments_by_parent_id
  end
  
  def new
    @post = Post.new
    render :new
  end
  
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  def edit
    @post = Post.find(params[:id])
    render :edit
  end
  
  def update
    @post = Post.find(params[:id])
    
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.subs.first)
  end
  
  def upvote
    vote(1)
  end
  
  def downvote
    vote(-1)
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
  
  def vote(value)
    @post = Post.find(params[:id])
    @vote = @post.votes.build(
      value: value, votable_id: params[:id], 
      votable_type: @post.class.name
    )
    
    @vote.save
    redirect_to post_url(@post)
  end
  
end
