# frozen_string_literal: true

class Api::V1::BaseApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render status: :not_found, json: { "error": 'Not Found' }.to_json
  end

  def must_be_signed_in
    render status: :unauthorized, json: {} if current_user.nil?
  end

  def current_user
    access_token = (request.headers['Authorization'] || '').gsub(/^Bearer /, '')
    @current_user = nil
    user = access_token.present? ? User.find_by(access_token: access_token) : nil
    @current_user = user if user.present? && user.token? && !user.token_expired?
    @current_user
  end
end
