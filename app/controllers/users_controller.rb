class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      redirect_to events_path
    else
      render :new
    end
  end

  def show
    @user = User.find_by_id params[:id]
  end


  private

  def user_params
    params.require(:user).permit(:email_address, :password, :first_name, :last_name)
  end
end