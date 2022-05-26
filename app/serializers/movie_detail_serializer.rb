# frozen_string_literal: true

class MovieDetailSerializer < ActiveModel::Serializer
  attribute :id
  attribute :name
  attribute :director
  attribute :release_year
  attribute :running_time
  attribute :language
  attribute :budget
  attribute :amount_favorites

  def budget
    "#{object.budget} million dollars"
  end
end
