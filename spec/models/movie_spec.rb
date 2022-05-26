# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  subject do
    described_class.new(
      name: 'test',
      director: 'test',
      release_year: 2021,
      running_time: 120,
      language: 'english',
      budget: 100,
      amount_favorites: 0
    )
  end

  context 'Create a movie' do
    it 'is valid with attributes valid' do
      expect(subject).to be_valid
    end

    it 'is not valid without name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without director' do
      subject.director = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without release_year' do
      subject.release_year = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without running_time' do
      subject.running_time = nil
      expect(subject).to_not be_valid
    end
  end

  context 'Create a movie with attributes are not unique' do
    let(:movie) { create(:movie, name: 'test') }

    before { movie }

    it 'is not valid with name is already exist' do
      expect(subject).to_not be_valid
    end
  end
end
