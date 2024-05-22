class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user.authenticate(params[:password])
      session[:user_id] = user.id
      cookies.encrypted[:user_id] = { value: user.id, expires: 30.days }
      cookies[:location] = params[:location]
      flash[:success] = "Welcome, #{user.name}"
      redirect_to user_path(user)
    else
      flash[:error] = 'Invalid email address or password.'
      render :new
    end
  end

  def destroy
    cookies.delete :user_id
    reset_session
    flash[:success] = 'Logged out successfully.'
    redirect_to root_path
  end
end