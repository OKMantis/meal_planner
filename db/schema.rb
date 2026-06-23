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

ActiveRecord::Schema[8.1].define(version: 2026_06_23_210131) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "ingredients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "unit"
    t.datetime "updated_at", null: false
  end

  create_table "meal_plan_entries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "meal_plan_id", null: false
    t.string "meal_slot"
    t.bigint "recipe_id", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_plan_id"], name: "index_meal_plan_entries_on_meal_plan_id"
    t.index ["recipe_id"], name: "index_meal_plan_entries_on_recipe_id"
  end

  create_table "meal_plans", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "planned_for"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_meal_plans_on_user_id"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "ingredient_id", null: false
    t.decimal "quantity"
    t.bigint "recipe_id", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipe_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "recipe_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipe_tags_on_recipe_id"
    t.index ["tag_id"], name: "index_recipe_tags_on_tag_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.integer "cook_time_minutes"
    t.datetime "created_at", null: false
    t.text "description"
    t.boolean "published"
    t.integer "servings"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["published"], name: "index_recipes_on_published"
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "role"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "meal_plan_entries", "meal_plans"
  add_foreign_key "meal_plan_entries", "recipes"
  add_foreign_key "meal_plans", "users"
  add_foreign_key "recipe_ingredients", "ingredients"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "recipe_tags", "recipes"
  add_foreign_key "recipe_tags", "tags"
  add_foreign_key "recipes", "users"
end
