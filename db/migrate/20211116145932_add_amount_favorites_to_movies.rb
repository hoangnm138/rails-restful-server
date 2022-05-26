# frozen_string_literal: true

class AddAmountFavoritesToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :amount_favorites, :integer, null: false, default: 0, comment: 'Amount of favorites'
  end
end
