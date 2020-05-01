class CreateEmployers < ActiveRecord::Migration[6.0]
  def change
    create_table :employers do |t|
      t.string :first_name
      t.string :paternal_last_name
      t.string :maternal_last_name
      t.string :gender
      t.date :birthday
      t.attachment :avatar
      t.attachment :curriculum_vitae
      t.string :rfc
      t.string :curp

      t.string :scholarship
      t.string :courses_description


      t.string :phone_number
      t.string :home_number
      t.string :email
      t.string :personal_email

      t.string :contract_number
      t.string :gross_salary
      t.string :net_salary
      t.date :entry_date
      t.date :validity
      t.string :insurance_number

      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code


      t.belongs_to :employers, :chief_id, index: true
      t.belongs_to :user, index: true
      t.belongs_to :degree, index: true
      t.timestamps
    end

    def self.down
      drop_attached_file :employers, :avatar
    end
  end
end
