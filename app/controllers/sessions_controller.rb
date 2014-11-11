class SessionsController < ApplicationController
  before_action :set_user, only: :create

  def new
    redirect_to events_path if current_user
  end

  def create
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:success] = "You did it. Login success!"
      redirect_to events_path
    elsif @user
      flash[:danger] = "That's not your password yo."
      render :new
    else
      flash[:danger] = "This is not the email address you are looking for."
      render :new
    end
  end

  private

  def set_user
    @user = User.find_by_email_address params[:user][:email_address]
  end
end
