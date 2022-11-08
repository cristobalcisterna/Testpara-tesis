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

ActiveRecord::Schema.define(version: 2022_10_25_161428) do

  create_table "buildings", force: :cascade do |t|
    t.string "name_building"
    t.string "identification_number_building"
    t.string "location_building"
    t.integer "duty_manager_id", precision: 38, null: false
    t.integer "unit_id", precision: 38, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "active_building", precision: 38
    t.index ["duty_manager_id"], name: "i_buildings_duty_manager_id"
    t.index ["unit_id"], name: "index_buildings_on_unit_id"
  end

  create_table "condition_goods", force: :cascade do |t|
    t.date "lost_date"
    t.text "loss_detail"
    t.date "destruction_date"
    t.text "destruction_detail"
    t.date "request_date"
    t.integer "request_status", precision: 38
    t.text "income_reason"
    t.date "date_entry"
    t.integer "condition_id", precision: 38, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "good_id", precision: 38, null: false
    t.string "repairable"
    t.text "link"
    t.integer "activeconditiongood", precision: 38
    t.index ["condition_id"], name: "i_condition_goods_condition_id"
    t.index ["good_id"], name: "i_condition_goods_good_id"
  end

  create_table "conditions", force: :cascade do |t|
    t.string "state_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "duty_managers", force: :cascade do |t|
    t.string "name_duty_manager"
    t.string "rut"
    t.integer "unit_id", precision: 38, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.integer "active_duty_manager", precision: 38
    t.integer "user_id", precision: 38, null: false
    t.index ["unit_id"], name: "index_duty_managers_on_unit_id"
    t.index ["user_id"], name: "index_duty_managers_on_user_id"
  end

  create_table "financial_sources", force: :cascade do |t|
    t.string "name_financial_source"
    t.text "detail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "active_financial_source", precision: 38
  end

  create_table "goods", force: :cascade do |t|
    t.string "namegood"
    t.text "good_description"
    t.string "identification_number_usach"
    t.string "identification_number_good"
    t.string "serie_number"
    t.string "internal_number"
    t.string "trademark"
    t.date "date_purchase"
    t.date "date_release"
    t.string "location_good"
    t.integer "amount", precision: 38
    t.integer "duty_manager_id", precision: 38, null: false
    t.integer "office_id", precision: 38, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "activegood", precision: 38
    t.integer "financial_source_id", precision: 38, null: false
    t.integer "investment_type_id", precision: 38, null: false
    t.index ["duty_manager_id"], name: "index_goods_on_duty_manager_id"
    t.index ["financial_source_id"], name: "i_goods_financial_source_id"
    t.index ["investment_type_id"], name: "i_goods_investment_type_id"
    t.index ["office_id"], name: "index_goods_on_office_id"
  end

  create_table "internal_position_permissions", force: :cascade do |t|
    t.integer "internal_position_id", precision: 38, null: false
    t.integer "permission_id", precision: 38, null: false
    t.integer "unit_id", precision: 38
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["internal_position_id"], name: "i_int_pos_per_int_pos_id"
    t.index ["permission_id"], name: "i_int_pos_per_per_id"
  end

  create_table "internal_positions", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.boolean "is_real"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "investment_types", force: :cascade do |t|
    t.string "name_investment_type"
    t.text "detail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "active_investment_type", precision: 38
  end

  create_table "offices", force: :cascade do |t|
    t.string "name_office"
    t.string "identification_number_office"
    t.string "location"
    t.text "office_description"
    t.integer "hours_available", precision: 38
    t.integer "square_meter", precision: 38
    t.string "campus_identification"
    t.integer "duty_manager_id", precision: 38, null: false
    t.integer "building_id", precision: 38, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "active_office", precision: 38
    t.index ["building_id"], name: "index_offices_on_building_id"
    t.index ["duty_manager_id"], name: "i_offices_duty_manager_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "subject_class", null: false
    t.string "action", null: false
    t.string "description"
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "name_unit"
    t.string "description_unit"
    t.string "identification_number_unit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "active_unit", precision: 38
  end

  create_table "user_internal_positions", force: :cascade do |t|
    t.integer "user_id", precision: 38, null: false
    t.integer "internal_position_id", precision: 38, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["internal_position_id"], name: "i_use_int_pos_int_pos_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.datetime "remember_created_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "disabled"
    t.integer "active_profile", precision: 38
    t.string "rut"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "i_users_reset_password_token", unique: true
  end

  add_foreign_key "buildings", "duty_managers"
  add_foreign_key "buildings", "units"
  add_foreign_key "condition_goods", "conditions"
  add_foreign_key "condition_goods", "goods"
  add_foreign_key "duty_managers", "units"
  add_foreign_key "duty_managers", "users"
  add_foreign_key "goods", "duty_managers"
  add_foreign_key "goods", "financial_sources"
  add_foreign_key "goods", "investment_types"
  add_foreign_key "goods", "offices"
  add_foreign_key "internal_position_permissions", "internal_positions"
  add_foreign_key "internal_position_permissions", "permissions"
  add_foreign_key "offices", "buildings"
  add_foreign_key "offices", "duty_managers"
  add_foreign_key "user_internal_positions", "internal_positions"
end
