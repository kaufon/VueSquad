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

ActiveRecord::Schema[8.0].define(version: 2024_12_09_133655) do
  create_table "squads", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_squads_on_owner_id"
  end

  create_table "squads_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "squad_id", null: false
    t.index ["squad_id", "user_id"], name: "index_squads_users_on_squad_id_and_user_id"
    t.index ["user_id", "squad_id"], name: "index_squads_users_on_user_id_and_squad_id"
  end

  create_table "users", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_squads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "squads", "users", column: "owner_id"
end
