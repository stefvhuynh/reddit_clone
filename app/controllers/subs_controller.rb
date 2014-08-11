class SubsController < ApplicationController
  before_filter :require_signed_in!, except: [:index, :show]
  
  def index
    @subs = Sub.all
    render :index
  end
  
  def show
    @sub = Sub.find(params[:id])
    
    @posts = @sub.posts.includes(:votes).sort do |post1, post2| 
      post2.vote_score <=> post1.vote_score
    end
    
    render :show
  end
  
  def update
    @sub = Sub.find(params[:id])
    
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end
  
  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def create
    @sub = current_user.subs.build(sub_params)
    
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def new
    @sub = Sub.new
    render :new
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to subs_url
  end

  private
  
  def sub_params
    params.require(:sub).permit(:name, :description)
  end

end
