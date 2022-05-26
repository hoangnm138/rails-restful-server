# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:full_name) { |n| "full_name_#{n}" }
    sequence(:user_name) { |n| "user_name_#{n}" }
    sequence(:password) { |n| "password_#{n}" }
  end
end
