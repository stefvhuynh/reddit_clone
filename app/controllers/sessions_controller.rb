class SessionsController < ApplicationController
  
  def create
    user = User.find_by_credentials(
      params[:session][:username],
      params[:session][:password]
    )
    
    if user.nil?
      flash.now[:errors] = ["Invalid username/password combination"]
      render :new
    else
      sign_in!(user)
      redirect_to subs_url
    end
  end
  
  def new
    render :new
  end

  def destroy
    sign_out!
    redirect_to new_session_url
  end
  
end
