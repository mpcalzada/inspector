# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200516191048) do

  create_table "attendance_trackers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "internal_id"
    t.string   "description"
    t.datetime "registered_datetime"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["user_id"], name: "index_attendance_trackers_on_user_id"
  end

  create_table "degrees", force: :cascade do |t|
    t.string   "description"
    t.integer  "department_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["department_id"], name: "index_degrees_on_department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "employers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "paternal_last_name"
    t.string   "maternal_last_name"
    t.integer  "gender"
    t.date     "birthday"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.bigint   "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "rfc"
    t.string   "curp"
    t.string   "nationality"
    t.integer  "marital_status"
    t.string   "scholarship"
    t.string   "masters_description"
    t.string   "phd_description"
    t.string   "courses_description"
    t.string   "phone_number"
    t.string   "personal_phone_number"
    t.integer  "home_type"
    t.integer  "home_financial_type"
    t.string   "home_number"
    t.string   "email"
    t.string   "personal_email"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "postal_code"
    t.string   "birthplace_city"
    t.string   "birthplace_country"
    t.string   "curriculum_vitae_file_name"
    t.string   "curriculum_vitae_content_type"
    t.bigint   "curriculum_vitae_file_size"
    t.datetime "curriculum_vitae_updated_at"
    t.string   "contract_number"
    t.string   "gross_salary"
    t.string   "net_salary"
    t.date     "entry_date"
    t.date     "validity"
    t.string   "insurance_number"
    t.time     "entrance_time"
    t.time     "exit_time"
    t.integer  "travel_capability"
    t.integer  "dependents_number"
    t.string   "blood_type"
    t.string   "allergies"
    t.string   "contact1_full_name"
    t.string   "contact1_relationship"
    t.string   "contact1_home_phone_number"
    t.string   "contact1_cellphone_number"
    t.string   "contact2_full_name"
    t.string   "contact2_relationship"
    t.string   "contact2_home_phone_number"
    t.string   "contact2_cellphone_number"
    t.integer  "employer_id"
    t.integer  "chief_id"
    t.integer  "user_id"
    t.integer  "degree_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["chief_id"], name: "index_employers_on_chief_id"
    t.index ["degree_id"], name: "index_employers_on_degree_id"
    t.index ["employer_id"], name: "index_employers_on_employer_id"
    t.index ["user_id"], name: "index_employers_on_user_id"
  end

  create_table "upload_files", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.bigint   "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["user_id"], name: "index_upload_files_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",               default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["unlock_token"], name: "index_users_on_unlock_token"
  end

end
