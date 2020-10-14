# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_14_130332) do

  create_table "checkouts", force: :cascade do |t|
    t.integer "product_id"
    t.string "discount_type"
    t.integer "discount_amount"
    t.integer "product_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_checkouts_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "product_code"
    t.string "name"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_code"], name: "index_products_on_product_code"
  end

  create_table "promotional_rules", force: :cascade do |t|
    t.integer "product_id"
    t.string "discount_type"
    t.float "discount_amount"
    t.integer "product_amount"
    t.integer "price_amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_promotional_rules_on_product_id"
  end

end
