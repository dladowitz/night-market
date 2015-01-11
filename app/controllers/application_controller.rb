class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  add_breadcrumb "Home",    :events_path
  add_breadcrumb "Events",  :events_path


  helper_method :current_user  #makes available in view


  #TODO move these out to a module
  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = "Access Denied. All your bases are belong to us."
    redirect_to home_path
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    flash[:danger] = "That's not a thing in the database"
    redirect_to home_path
  end


  def current_user
    User.find session[:user_id] if session[:user_id]
  end

  def require_user
    unless current_user
      flash[:danger] = "You must be logged in to do that."
      redirect_to signin_path
    end
  end

  def login_user(user)
    session[:user_id] = user.id
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

  #bootstrap ruby doesn't like datetimepicker's ordering of day and month. Not the most efficient
  def bootstrap_datetime_to_rb_datetime(boostrap_dt_string)
    DateTime.strptime(boostrap_dt_string, "%m/%d/%Y %l:%M %p").to_s
  end
end
