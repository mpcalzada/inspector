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

ActiveRecord::Schema.define(version: 2020_08_29_034130) do

  create_table "account_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "account_number"
    t.decimal "current_balance", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "monthly_income", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "monthly_withdrawal", precision: 8, scale: 2, default: "0.0", null: false
    t.integer "account_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_type_id"], name: "index_accounts_on_account_type_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "attendance_trackers", force: :cascade do |t|
    t.integer "employer_id"
    t.integer "justification_reason_id"
    t.string "name"
    t.integer "internal_id"
    t.string "description"
    t.string "justification_description"
    t.datetime "registered_datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id", "registered_datetime"], name: "unique_register_datetime_for_attendance", unique: true
    t.index ["employer_id"], name: "index_attendance_trackers_on_employer_id"
    t.index ["justification_reason_id"], name: "index_attendance_trackers_on_justification_reason_id"
  end

  create_table "clients", force: :cascade do |t|
    t.boolean "is_buisiness_entity"
    t.string "full_name"
    t.string "city"
    t.string "address"
    t.string "contact_email"
    t.string "contact_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "degrees", force: :cascade do |t|
    t.string "description"
    t.integer "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_degrees_on_department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employer_punctuations", force: :cascade do |t|
    t.integer "performance"
    t.integer "punctuality"
    t.integer "attendance"
    t.integer "attitude"
    t.integer "quality"
    t.integer "employer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_employer_punctuations_on_employer_id"
  end

  create_table "employers", force: :cascade do |t|
    t.string "first_name"
    t.string "paternal_last_name"
    t.string "maternal_last_name"
    t.integer "gender"
    t.date "birthday"
    t.string "rfc"
    t.string "curp"
    t.string "nationality"
    t.integer "marital_status"
    t.string "scholarship"
    t.string "masters_description"
    t.string "phd_description"
    t.string "courses_description"
    t.string "phone_number"
    t.string "personal_phone_number"
    t.integer "home_type"
    t.integer "home_financial_type"
    t.string "home_number"
    t.string "email"
    t.string "personal_email"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "postal_code"
    t.string "birthplace_city"
    t.string "birthplace_country"
    t.string "identification_number"
    t.string "contract_number"
    t.string "gross_salary"
    t.string "net_salary"
    t.date "entry_date"
    t.date "validity"
    t.string "insurance_number"
    t.time "entrance_time"
    t.time "exit_time"
    t.integer "travel_capability"
    t.integer "dependents_number"
    t.string "blood_type"
    t.string "allergies"
    t.string "diseases"
    t.string "contact1_full_name"
    t.string "contact1_relationship"
    t.string "contact1_home_phone_number"
    t.string "contact1_cellphone_number"
    t.string "contact2_full_name"
    t.string "contact2_relationship"
    t.string "contact2_home_phone_number"
    t.string "contact2_cellphone_number"
    t.integer "employer_id"
    t.integer "chief_id"
    t.integer "user_id"
    t.integer "degree_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chief_id"], name: "index_employers_on_chief_id"
    t.index ["degree_id"], name: "index_employers_on_degree_id"
    t.index ["employer_id"], name: "index_employers_on_employer_id"
    t.index ["user_id"], name: "index_employers_on_user_id"
  end

  create_table "justification_reasons", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loan_histories", force: :cascade do |t|
    t.date "paid_date", null: false
    t.decimal "amount", precision: 8, scale: 2, null: false
    t.integer "paid_type", null: false
    t.decimal "remaining_amount", precision: 8, scale: 2, null: false
    t.integer "loan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_loan_histories_on_loan_id"
  end

  create_table "loans", force: :cascade do |t|
    t.string "monthly_payment"
    t.float "amount"
    t.float "total_amount"
    t.float "total_interest"
    t.float "amount_paid", default: 0.0, null: false
    t.float "penalization_duty", default: 0.0, null: false
    t.float "prepayment_amount", default: 0.0, null: false
    t.integer "monthly_term"
    t.float "interest_rate"
    t.date "loan_date", null: false
    t.date "next_payment", null: false
    t.integer "current_month", default: 0, null: false
    t.boolean "paid", default: false, null: false
    t.integer "employer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_loans_on_employer_id"
  end

  create_table "old_passwords", force: :cascade do |t|
    t.string "encrypted_password", null: false
    t.string "password_archivable_type", null: false
    t.integer "password_archivable_id", null: false
    t.datetime "created_at"
    t.string "password_salt"
    t.index ["password_archivable_type", "password_archivable_id"], name: "index_password_archivable"
  end

  create_table "providers", force: :cascade do |t|
    t.boolean "is_business_entity"
    t.string "full_name"
    t.string "city"
    t.string "address"
    t.string "contact_email"
    t.string "contact_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "upload_files", force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "password_changed_at"
    t.string "unique_session_id", limit: 30
    t.datetime "last_activity_at"
    t.datetime "expired_at"
    t.boolean "is_active"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["unlock_token"], name: "index_users_on_unlock_token"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

end
