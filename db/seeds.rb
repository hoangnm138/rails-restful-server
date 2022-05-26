# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# movies
movies = CSV.read(Rails.root.join('db/seeds/csv/movies.csv'), headers: true)
all_movies = movies.map do |row|
  Movie.find_or_create_by(name: row['name']) do |movie|
    movie.director = row['director']
    movie.release_year = row['release_year'].to_i
    movie.running_time = row['running_time'].to_i
    movie.language = row['language']
    movie.budget = row['budget'].nil? ? nil : row['budget'].to_i
  end
end

# FOR TEST
# users
users = (1..10).map do |n|
  User.find_or_create_by(user_name: "user_name_#{n}") do |user|
    user.full_name = "full_name_#{n}"
    user.password = SecureRandom.alphanumeric(20)
  end
end

# users favor movies
users.each do |user|
  all_movies.shuffle.take(rand(5)).each do |movie|
    favorite = Favorite.find_or_initialize_by(user_id: user.id, movie_id: movie.id)
    if favorite.id.nil?
      favorite.save
      movie.update(amount_favorites: movie.amount_favorites + 1)
    end
  end
end
