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

ActiveRecord::Schema[7.1].define(version: 2024_11_23_120637) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "checkouts", force: :cascade do |t|
    t.string "reference_number"
    t.date "date_of_retrieval"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colors", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "size"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.index ["product_id"], name: "index_colors_on_product_id"
  end

  create_table "customer_orders", force: :cascade do |t|
    t.string "customer_email"
    t.string "name"
    t.string "phone_number"
    t.string "reference_number"
    t.date "date_of_retrieval"
    t.decimal "total"
    t.string "size"
    t.integer "quantity"
    t.string "items"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mixes", force: :cascade do |t|
    t.integer "paint_color_id", null: false
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "primary_color_id"
    t.integer "order_id"
    t.index ["paint_color_id"], name: "index_mixes_on_paint_color_id"
  end

  create_table "mixture_details", force: :cascade do |t|
    t.integer "mixture_id", null: false
    t.integer "order_id"
    t.integer "primary_color_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mixture_id"], name: "index_mixture_details_on_mixture_id"
  end

  create_table "mixture_thirds", force: :cascade do |t|
    t.integer "mixture_id", null: false
    t.integer "order_id"
    t.integer "primary_color_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mixture_id"], name: "index_mixture_thirds_on_mixture_id"
  end

  create_table "mixtures", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "primary_color_id", null: false
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_mixtures_on_order_id"
    t.index ["primary_color_id"], name: "index_mixtures_on_primary_color_id"
  end

  create_table "order_paint_colors", force: :cascade do |t|
    t.integer "paint_color_id", null: false
    t.integer "order_id", null: false
    t.string "size"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_paint_colors_on_order_id"
    t.index ["paint_color_id"], name: "index_order_paint_colors_on_paint_color_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "customer_email"
    t.boolean "fulfilled"
    t.integer "total"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reference_number"
    t.datetime "date_of_retrieval"
    t.integer "color_id"
    t.integer "product_id"
    t.integer "paint_color_id"
    t.integer "primary_color_id"
  end

  create_table "paint_colors", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "size"
    t.integer "quantity"
    t.integer "price"
    t.integer "color_id", null: false
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id"
    t.integer "previous_stocks"
    t.integer "added_stocks"
    t.index ["color_id"], name: "index_paint_colors_on_color_id"
    t.index ["product_id"], name: "index_paint_colors_on_product_id"
  end

  create_table "primary_color_stocks", force: :cascade do |t|
    t.string "size"
    t.decimal "quantity"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "primary_colors", force: :cascade do |t|
    t.string "color_name"
    t.string "color_code"
    t.decimal "price"
    t.decimal "stocks"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "previous_stocks"
    t.integer "added_stocks"
  end

  create_table "product_stocks", force: :cascade do |t|
    t.integer "product_id", null: false
    t.string "size"
    t.decimal "amount"
    t.decimal "price"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_stocks_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "active"
    t.text "color_name"
    t.text "color_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "color_id"
    t.integer "orders_id"
    t.index ["orders_id"], name: "index_products_on_orders_id"
  end

  create_table "sales", force: :cascade do |t|
    t.decimal "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "selects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stock_movements", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "primary_color_id", null: false
    t.integer "paint_color_id", null: false
    t.string "movement_type"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["paint_color_id"], name: "index_stock_movements_on_paint_color_id"
    t.index ["primary_color_id"], name: "index_stock_movements_on_primary_color_id"
    t.index ["product_id"], name: "index_stock_movements_on_product_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "size"
    t.integer "amount"
    t.integer "paint_color_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price"
    t.index ["paint_color_id"], name: "index_stocks_on_paint_color_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "colors", "products"
  add_foreign_key "mixes", "orders"
  add_foreign_key "mixes", "paint_colors"
  add_foreign_key "mixes", "primary_colors"
  add_foreign_key "mixture_details", "mixtures"
  add_foreign_key "mixture_thirds", "mixtures"
  add_foreign_key "mixtures", "orders"
  add_foreign_key "mixtures", "primary_colors"
  add_foreign_key "order_paint_colors", "orders"
  add_foreign_key "order_paint_colors", "paint_colors"
  add_foreign_key "orders", "colors"
  add_foreign_key "orders", "paint_colors"
  add_foreign_key "orders", "primary_colors"
  add_foreign_key "orders", "products"
  add_foreign_key "paint_colors", "colors"
  add_foreign_key "paint_colors", "products"
  add_foreign_key "product_stocks", "products"
  add_foreign_key "products", "orders", column: "orders_id"
  add_foreign_key "stock_movements", "paint_colors"
  add_foreign_key "stock_movements", "primary_colors"
  add_foreign_key "stock_movements", "products"
  add_foreign_key "stocks", "paint_colors"
end
