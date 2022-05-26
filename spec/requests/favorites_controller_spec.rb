# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::FavoritesController, type: :request do
  let(:movies) { Movie.all }

  describe 'GET favorites/' do
    subject do
      get '/ml_backend/api/v1/favorites', headers: headers
    end

    context 'is successful' do
      let(:headers) do
        {
          "Authorization": "Bearer #{@current_user.access_token}"
        }
      end
      let(:favorite_movies) { movies.shuffle.take(5) }
      let(:favorites) do
        favorite_movies.map do |movie|
          create(:favorite, user: @current_user, movie: movie)
        end
      end

      before do
        login_user
        favorites
        subject
      end

      it 'return 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'return 5 favorite movies' do
        expect(response_body.size).to eq(5)
        expect(response_body.map { |i| i[:id] }).to match_array(favorite_movies.map(&:id))
      end
    end

    context 'have errors' do
      context 'when user do not login' do
        let(:headers) { nil }

        before { subject }

        it 'return 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  describe 'POST favorites?movie_id' do
    let(:params) { nil }

    subject do
      post '/ml_backend/api/v1/favorites', params: params, headers: headers
    end

    context 'is successful' do
      let(:headers) do
        {
          "Authorization": "Bearer #{@current_user.access_token}"
        }
      end
      let(:favorites_movie) { movies.sample }
      let(:params) do
        { movie_id: favorites_movie.id }
      end

      before do
        login_user
        subject
      end

      it 'return 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'have errors' do
      context 'when movie is not exist' do
        let(:headers) do
          {
            "Authorization": "Bearer #{@current_user.access_token}"
          }
        end
        let(:params) do
          { movie_id: 1000 }
        end

        before do
          login_user
          subject
        end

        it 'return 404' do
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'when movie is favorited' do
        let(:headers) do
          {
            "Authorization": "Bearer #{@current_user.access_token}"
          }
        end
        let(:favorites_movie) { movies.sample }
        let(:params) do
          { movie_id: favorites_movie.id }
        end

        before do
          login_user
          create(:favorite, user: @current_user, movie: favorites_movie)
          subject
        end

        it 'return 400' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when user do not login' do
        let(:headers) { nil }

        before { subject }

        it 'return 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
