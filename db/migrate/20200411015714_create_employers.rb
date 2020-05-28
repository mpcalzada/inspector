class CreateEmployers < ActiveRecord::Migration[5.0]
  def change
    create_table :employers do |t|
      t.string :first_name
      t.string :paternal_last_name
      t.string :maternal_last_name
      t.integer :gender
      t.date :birthday
      t.attachment :avatar
      t.string :rfc
      t.string :curp
      t.string :nationality
      t.integer :marital_status

      t.string :scholarship
      t.string :masters_description
      t.string :phd_description
      t.string :courses_description

      t.string :phone_number
      t.string :personal_phone_number
      t.integer :home_type
      t.integer :home_financial_type
      t.string :home_number
      t.string :email
      t.string :personal_email
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code
      t.string :birthplace_city
      t.string :birthplace_country

      t.string :identification_number
      t.attachment :curriculum_vitae
      t.string :contract_number
      t.string :gross_salary
      t.string :net_salary
      t.date :entry_date
      t.date :validity
      t.string :insurance_number
      t.time :entrance_time
      t.time :exit_time

      t.integer :travel_capability
      t.integer :dependents_number
      t.string :blood_type
      t.string :allergies
      t.string :diseases

      t.string :contact1_full_name
      t.string :contact1_relationship
      t.string :contact1_home_phone_number
      t.string :contact1_cellphone_number
      t.string :contact2_full_name
      t.string :contact2_relationship
      t.string :contact2_home_phone_number
      t.string :contact2_cellphone_number


      t.belongs_to :employer, :chief, index: true
      t.belongs_to :user, index: true
      t.belongs_to :degree, index: true
      t.timestamps
    end

    def self.down
      drop_attached_file :employers, :avatar
      drop_attached_file :employers, :curriculum_vitae
    end
  end
end
