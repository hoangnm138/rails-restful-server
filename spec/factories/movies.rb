# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    sequence(:name) { |n| "movie_name_#{n}" }
    sequence(:director) { |n| "director_#{n}" }
    release_year { 2021 }
    running_time { rand(10..300) }
    language { %w[english japanese].sample }
    budget { rand(1000) }
    amount_favorites { 0 }
  end
end
