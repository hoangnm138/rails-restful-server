# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies, comment: 'Movies' do |t|
      t.string  :name,         null: false, comment: 'movie name'
      t.string  :director,     null: false, comment: 'movie director'
      t.integer :release_year, null: false, comment: 'movie release year'
      t.integer :running_time, null: false, comment: 'running time (minutes)'
      t.string  :language,     null: true,  comment: 'movie language'
      t.integer :budget,       null: true,  comment: 'movie budget (million dollars)'

      t.timestamps
    end
  end
end
