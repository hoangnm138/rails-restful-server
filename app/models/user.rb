# frozen_string_literal: true

class User < ApplicationRecord
  TOKEN_LIFE_TIME = 12.hours

  has_secure_password
  has_many :favorites

  validates :full_name, presence: { message: 'Please input full name' }
  validates :user_name, presence: { message: 'Please input username' },
                        uniqueness: { message: 'is already exist' }

  def update_token
    now = Time.now
    access_token = Digest::SHA1.hexdigest([now, rand].join)
    update(access_token: access_token, token_expire_at: now + TOKEN_LIFE_TIME)
  end

  def reset_token
    update(access_token: nil, token_expire_at: nil)
  end

  def token?
    access_token.present? && token_expire_at.present?
  end

  def token_expired?
    token_expire_at.present? && token_expire_at < Time.now
  end
end
