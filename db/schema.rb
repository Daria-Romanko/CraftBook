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

ActiveRecord::Schema[8.0].define(version: 2024_12_21_111555) do
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

  create_table "ingredient_recipes", force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "ingredient_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_ingredient_recipes_on_ingredient_id"
    t.index ["recipe_id"], name: "index_ingredient_recipes_on_recipe_id"
  end

  create_table "ingredient_tags", force: :cascade do |t|
    t.integer "ingredient_id", null: false
    t.integer "tag_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_ingredient_tags_on_ingredient_id"
    t.index ["tag_id"], name: "index_ingredient_tags_on_tag_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id"
    t.index ["project_id"], name: "index_ingredients_on_project_id"
  end

  create_table "ingredients_recipes", force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "ingridient_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingridient_id"], name: "index_ingredients_recipes_on_ingridient_id"
    t.index ["recipe_id"], name: "index_ingredients_recipes_on_recipe_id"
  end

  create_table "ingredients_tags", force: :cascade do |t|
    t.integer "ingridient_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingridient_id"], name: "index_ingredients_tags_on_ingridient_id"
    t.index ["tag_id"], name: "index_ingredients_tags_on_tag_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "recipe_tags", force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity"
    t.index ["recipe_id"], name: "index_recipe_tags_on_recipe_id"
    t.index ["tag_id"], name: "index_recipe_tags_on_tag_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.integer "project_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["project_id"], name: "index_recipes_on_project_id"
  end

  create_table "recipes_tags", force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "tag_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipes_tags_on_recipe_id"
    t.index ["tag_id"], name: "index_recipes_tags_on_tag_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id"
    t.integer "quantity"
    t.text "description"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ingredient_recipes", "ingredients"
  add_foreign_key "ingredient_recipes", "recipes"
  add_foreign_key "ingredient_tags", "ingredients"
  add_foreign_key "ingredient_tags", "tags"
  add_foreign_key "ingredients", "projects"
  add_foreign_key "ingredients_recipes", "ingridients"
  add_foreign_key "ingredients_recipes", "recipes"
  add_foreign_key "ingredients_tags", "ingridients"
  add_foreign_key "ingredients_tags", "tags"
  add_foreign_key "projects", "users"
  add_foreign_key "recipe_tags", "recipes"
  add_foreign_key "recipe_tags", "tags"
  add_foreign_key "recipes", "projects"
  add_foreign_key "recipes_tags", "recipes"
  add_foreign_key "recipes_tags", "tags"
  add_foreign_key "sessions", "users"
  add_foreign_key "tags", "projects"
end
