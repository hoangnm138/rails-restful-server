# frozen_string_literal: true

class WebController < ApplicationController
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :require_login
  before_action :session_expires

  def require_login
    redirect_to login_path unless logged_in?
  end

  def session_expires
    return unless session_expired?

    web_user.reset_token
    logout
    redirect_to login_path
  end
end
