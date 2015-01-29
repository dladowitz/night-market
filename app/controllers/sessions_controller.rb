class SessionsController < ApplicationController
  layout "guest"

  before_action :set_user, only: :create

  def new
    redirect_to events_path if current_user
  end

  def create
    if @user && @user.authenticate(params[:password])
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

  def destroy
    if current_user
      session[:user_id] = nil
      flash[:success] = "Bye Bye. Have fun storming the castle!"
    else
      flash[:danger] = "Errr, you can't log out when you aren't logged in. That's science."
    end

    # TODO redirect_to root_path. Not sure why this calls destroy method one more time
    redirect_to signin_path
  end

  private

  def set_user
    @user = User.find_by_email_address (params[:email_address]).downcase
  end
end
