# frozen_string_literal: true

class Api::V1::MoviesController < Api::V1::BaseApiController
  POPULAR_COUNT = 5

  def index
    movies = if search_params[:search].present?
               Movie.where('name ILIKE ?', "%#{search_params[:search]}%")
             else
               Movie.order(amount_favorites: :desc).take(POPULAR_COUNT)
             end

    render status: :ok, json: movies, each_serializer: MovieBasicSerializer
  end

  def show
    movie = Movie.find(params[:id])

    render status: :ok, json: movie, serializer: MovieDetailSerializer
  end

  private

  def search_params
    params.permit(:search)
  end
end
