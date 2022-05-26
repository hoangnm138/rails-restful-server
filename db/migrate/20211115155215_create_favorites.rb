# frozen_string_literal: true

class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :user,  null: false, foreign_key: true, comment: 'User Id', type: :uuid
      t.references :movie, null: false, foreign_key: true, comment: 'Movie Id'

      t.timestamps
    end

    add_index :favorites, %i[user_id movie_id], unique: true
  end
end
