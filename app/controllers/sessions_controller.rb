# frozen_string_literal: true

class SessionsController < WebController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    user = User.find_by(user_name: params[:session][:user_name].downcase)
    if user&.authenticate(params[:session][:password])
      flash[:success] = 'Login success'
      user.update_token
      login(user)
      redirect_to users_path
    else
      flash[:danger] = 'Invalid username/password'
      render :new
    end
  end

  def destroy
    web_user.reset_token
    logout
    flash[:success] = 'You are logged out'
    redirect_to login_path
  end
end
