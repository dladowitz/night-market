class UsersController < ApplicationController
  # before_action :require_user,  only: [:index, :show]
  # before_action :require_admin, only: :index

  load_and_authorize_resource

  def index
  end

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
    unless @user
      redirect_to users_path
    end
  end


  private

  def user_params
    params.require(:user).permit(:email_address, :password, :first_name, :last_name)
  end
end
