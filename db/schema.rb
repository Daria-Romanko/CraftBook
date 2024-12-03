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

ActiveRecord::Schema[8.0].define(version: 2024_12_01_073941) do
  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingridients_recipes", force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "ingridient_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingridient_id"], name: "index_ingridients_recipes_on_ingridient_id"
    t.index ["recipe_id"], name: "index_ingridients_recipes_on_recipe_id"
  end

  create_table "ingridients_tags", force: :cascade do |t|
    t.integer "ingridient_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingridient_id"], name: "index_ingridients_tags_on_ingridient_id"
    t.index ["tag_id"], name: "index_ingridients_tags_on_tag_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.integer "project_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "ingridients_recipes", "ingridients"
  add_foreign_key "ingridients_recipes", "recipes"
  add_foreign_key "ingridients_tags", "ingridients"
  add_foreign_key "ingridients_tags", "tags"
  add_foreign_key "projects", "users"
  add_foreign_key "recipes", "projects"
  add_foreign_key "recipes_tags", "recipes"
  add_foreign_key "recipes_tags", "tags"
  add_foreign_key "sessions", "users"
end