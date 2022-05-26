# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :request do
  describe 'GET movies/?search={search}' do
    let(:movies) do
      (1..10).map do |n|
        create(:movie, name: "test movie #{n}", amount_favorites: n)
      end
    end

    subject do
      get '/ml_backend/api/v1/movies', params: search_params
    end

    context 'have search param' do
      let(:search_movie) { movies.first }
      let(:search_params) do
        { search: search_movie.name }
      end

      before do
        movies
        subject
      end

      it 'return 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'return a movie' do
        movie_response = response_body.first
        expect(movie_response[:id]).to eq(search_movie.id)
        expect(movie_response[:name]).to eq(search_movie.name)
        expect(movie_response[:releaseYear]).to eq(search_movie.release_year)
        expect(movie_response[:amountFavorites]).to eq(search_movie.amount_favorites)
      end
    end

    context 'have not search param' do
      let(:search_params) { nil }

      before do
        movies
        subject
      end

      it 'return 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'return 5 popular movies' do
        expect(response_body.size).to eq(5)
        expect(response_body.map { |i| i[:id] }).to match_array(movies.last(5).map(&:id))
      end
    end
  end

  describe 'GET movies/:id' do
    subject do
      get "/ml_backend/api/v1/movies/#{movie_id}"
    end

    context 'is successful' do
      let(:movie_id) { Movie.first.id }

      before { subject }

      it 'return 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'return a detail movie' do
        movie = Movie.find(movie_id)
        expect(response_body[:id]).to eq(movie.id)
        expect(response_body[:director]).to eq(movie.director)
        expect(response_body[:releaseYear]).to eq(movie.release_year)
      end
    end

    context 'have error when movie is not exist' do
      let(:movie_id) { 10_000 }

      before { subject }

      it 'return 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
