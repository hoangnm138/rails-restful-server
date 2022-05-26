# frozen_string_literal: true

module SessionsHelper
  def login(user)
    session[:user_id] = user.id
    session[:expires_at] = user.token_expire_at
  end

  def logout
    session.delete(:user_id)
    session.delete(:expires_at)
  end

  # GET web user
  def web_user
    @web_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    web_user.present?
  end

  def session_expired?
    session[:expires_at].present? && session[:expires_at] < Time.now
  end
end
