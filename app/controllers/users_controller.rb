class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    render :show
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def edit
    @user = User.new
    render :edit
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      sign_in!(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to subs_url
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
