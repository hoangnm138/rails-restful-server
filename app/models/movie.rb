# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :favorites

  validates :name, presence: { message: 'Please input movie name' },
                   uniqueness: { message: 'is already exist' }
  validates :director, presence: { message: 'Please input director' }
  validates :release_year, numericality: { message: 'Please input release_year' }
  validates :running_time, numericality: { message: 'Please input running_time' }
end
