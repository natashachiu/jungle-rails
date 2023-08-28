class SessionsController < ApplicationController
  def index
    redirect_to login_path
  end

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
