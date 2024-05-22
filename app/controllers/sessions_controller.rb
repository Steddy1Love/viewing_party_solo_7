class SessionsController < ApplicationController
  def new
    
  end
  
  def create
    user = User.find_by(username: params[:username])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.username}"
      if user.admin?
        redirect_to admin_dashboard_path
      elsif user.manager?
        redirect_to root_path
      else
        redirect_to root_path
      end
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end
end