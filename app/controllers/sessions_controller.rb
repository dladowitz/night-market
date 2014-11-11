class SessionsController < ApplicationController
  before_action :set_user, only: :create

  def new
    redirect_to events_path if current_user
  end

  def create
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Login success! Have fun storming the castle."
      redirect_to events_path
    elsif @user
      flash[:danger] = "That's not your password yo."
      render :new
    else
      flash[:danger] = "This is not the email address you are looking for."
      render :new
    end
  end

  def destroy
    if current_user
      session[:user_id] = nil
      flash[:success] = "Logged out. Don't be a stranger"
    else
      flash[:danger] = "Errr, you can't log out when you aren't logged in. That's science."
    end

    redirect_to signin_path
  end

  private

  def set_user
    @user = User.find_by_email_address params[:email_address]
  end
end
