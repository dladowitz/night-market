module ControllerSpecHelpers
  def login_user(account = nil)
    unless account
      account = create :user
    end

    session[:user_id] = account.id
  end

  def logout_user
    session[:user_id] = nil
  end
end
