class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user  #makes available in view

  def current_user
    User.find session[:user_id] if session[:user_id]
  end

  def require_user
    unless current_user
      flash[:danger] = "You must be logged in to do that."
      redirect_to signin_path
    end
  end

  def require_admin
    if current_user && current_user.admin?
      return true
    elsif current_user
      flash[:danger] = "You must be an Admin to do that."
      redirect_to user_path(current_user)
    else
      require_user
    end
  end
end
