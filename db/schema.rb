# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_17_032402) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorites", force: :cascade do |t|
    t.uuid "user_id", null: false, comment: "User Id"
    t.bigint "movie_id", null: false, comment: "Movie Id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_favorites_on_movie_id"
    t.index ["user_id", "movie_id"], name: "index_favorites_on_user_id_and_movie_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "movies", comment: "Movies", force: :cascade do |t|
    t.string "name", null: false, comment: "movie name"
    t.string "director", null: false, comment: "movie director"
    t.integer "release_year", null: false, comment: "movie release year"
    t.integer "running_time", null: false, comment: "running time (minutes)"
    t.string "language", comment: "movie language"
    t.integer "budget", comment: "movie budget"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "amount_favorites", default: 0, null: false, comment: "Amount of favorites"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "Users", force: :cascade do |t|
    t.string "full_name", null: false, comment: "Fullname"
    t.string "user_name", null: false, comment: "Username"
    t.string "password_digest", null: false, comment: "secure password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "access_token", comment: "Access Token"
    t.datetime "token_expire_at", comment: "Token expire time"
    t.index ["user_name"], name: "index_users_on_user_name", unique: true
  end

  add_foreign_key "favorites", "movies"
  add_foreign_key "favorites", "users"
end
