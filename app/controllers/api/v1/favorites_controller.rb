# frozen_string_literal: true

class Api::V1::FavoritesController < Api::V1::BaseApiController
  before_action :must_be_signed_in

  def index
    movies = Movie.includes(:favorites)
                  .where(favorites: { user_id: current_user.id })
                  .order(created_at: :desc)
    render status: :ok, json: movies, each_serializer: MovieBasicSerializer
  end

  def create
    movie = Movie.find(params[:movie_id])
    favorite = Favorite.new(movie: movie, user: current_user)

    if favorite.save
      render status: :ok, json: {}
    else
      render status: :bad_request, json: { error: favorite.errors.messages.map { |k, v| "#{k} #{v.join(',')}" } }
    end
  end
end
