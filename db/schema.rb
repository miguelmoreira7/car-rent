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

ActiveRecord::Schema[8.0].define(version: 2025_03_18_211418) do
  create_table "cars", force: :cascade do |t|
    t.string "model"
    t.integer "year"
    t.string "fuel_type"
    t.integer "manufacturer_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "city_mpg"
    t.integer "combination_mpg"
    t.integer "cylinders"
    t.float "displacement"
    t.string "drive"
    t.integer "highway_mpg"
    t.string "transmission"
    t.string "car_class"
    t.string "make"
    t.decimal "price"
    t.decimal "daily_rental_price"
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer "cart_id"
    t.integer "car_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.integer "user_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservation_items", force: :cascade do |t|
    t.integer "reservation_id", null: false
    t.integer "car_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_reservation_items_on_car_id"
    t.index ["reservation_id"], name: "index_reservation_items_on_reservation_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "total_price"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "user_infos", force: :cascade do |t|
    t.integer "user_id"
    t.string "address"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "reservation_items", "cars"
  add_foreign_key "reservation_items", "reservations"
  add_foreign_key "reservations", "users"
end
