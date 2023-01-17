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

ActiveRecord::Schema[7.0].define(version: 2023_01_17_045939) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "backet_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "backet_id", null: false
    t.uuid "item_id", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["backet_id", "item_id"], name: "index_backet_items_on_backet_id_and_item_id", unique: true
    t.index ["backet_id"], name: "index_backet_items_on_backet_id"
    t.index ["item_id"], name: "index_backet_items_on_item_id"
  end

  create_table "backets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "my_api_keys", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "暗号化サンプル", force: :cascade do |t|
    t.string "encrypted_key", null: false
    t.string "key_salt", null: false
    t.string "key_cipher", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "backet_items", "backets"
  add_foreign_key "backet_items", "items"
end
