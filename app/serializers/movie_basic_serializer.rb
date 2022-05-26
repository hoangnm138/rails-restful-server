# frozen_string_literal: true

class MovieBasicSerializer < ActiveModel::Serializer
  attribute :id
  attribute :name
  attribute :release_year
  attribute :amount_favorites
end
