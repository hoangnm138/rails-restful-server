# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { create(:user, user_name: 'test') }
  let(:movie) { create(:movie) }

  subject do
    described_class.new(
      user_id: user.id,
      movie_id: movie.id
    )
  end

  context 'create a favorite' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without user_id' do
      subject.user_id = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without movie_id' do
      subject.movie_id = nil
      expect(subject).to_not be_valid
    end
  end

  context 'create a favorite when favorite is already exist' do
    before { create(:favorite, user: user, movie: movie) }

    it 'is not valid' do
      expect(subject).to_not be_valid
    end
  end
end
