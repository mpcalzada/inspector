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

ActiveRecord::Schema.define(version: 2020_04_11_015714) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendance_trackers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.integer "internal_id"
    t.string "description"
    t.datetime "registered_datetime"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_attendance_trackers_on_user_id"
  end

  create_table "degrees", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "employers", force: :cascade do |t|
    t.string "first_name"
    t.string "paternal_last_name"
    t.string "maternal_last_name"
    t.string "gender"
    t.date "birthday"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "curriculum_vitae_file_name"
    t.string "curriculum_vitae_content_type"
    t.bigint "curriculum_vitae_file_size"
    t.datetime "curriculum_vitae_updated_at"
    t.string "rfc"
    t.string "curp"
    t.string "scholarship"
    t.string "courses_description"
    t.string "phone_number"
    t.string "home_number"
    t.string "email"
    t.string "personal_email"
    t.string "contract_number"
    t.string "gross_salary"
    t.string "net_salary"
    t.date "entry_date"
    t.date "validity"
    t.string "insurance_number"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "postal_code"
    t.bigint "employers_id"
    t.bigint "chief_id_id"
    t.bigint "user_id"
    t.bigint "degree_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chief_id_id"], name: "index_employers_on_chief_id_id"
    t.index ["degree_id"], name: "index_employers_on_degree_id"
    t.index ["employers_id"], name: "index_employers_on_employers_id"
    t.index ["user_id"], name: "index_employers_on_user_id"
  end

  create_table "upload_files", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "file_file_name"
    t.string "file_content_type"
    t.bigint "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_upload_files_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["unlock_token"], name: "index_users_on_unlock_token"
  end

end
