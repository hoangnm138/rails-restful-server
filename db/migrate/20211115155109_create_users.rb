# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid, comment: 'Users' do |t|
      t.string :full_name,       null: false, comment: 'Fullname'
      t.string :user_name,       null: false, comment: 'Username', index: { unique: true }
      t.string :password_digest, null: false, comment: 'secure password'

      t.timestamps
    end
  end
end
