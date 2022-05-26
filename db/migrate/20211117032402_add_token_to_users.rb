# frozen_string_literal: true

class AddTokenToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :access_token,    :string,   null: true, comment: 'Access Token'
    add_column :users, :token_expire_at, :datetime, null: true, comment: 'Token expire time'
  end
end
