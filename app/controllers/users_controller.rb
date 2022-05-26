# frozen_string_literal: true

class UsersController < WebController
  skip_before_action :require_login, only: %i[new create]

  def index; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Register success'
      redirect_to root_path
    else
      flash[:danger] = 'Register failed'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(%i[full_name user_name password assword_confirmation])
  end
end
