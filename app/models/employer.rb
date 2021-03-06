class Employer < ApplicationRecord
  belongs_to :degree
  belongs_to :user
  has_one :employer_punctuation
  has_many :attendance_trackers
  has_many :attendance_overviews
  has_many :loans

  has_one_attached :avatar
  has_one_attached :curriculum_vitae
  has_many_attached :scholarship_attachments
  has_many_attached :master_attachments
  has_many_attached :phd_attachments
  has_many_attached :courses_attachments

  def self.current_employer(user_id)
    Employer.find_by_user_id(user_id)
  end

  def full_name
    "#{self.paternal_last_name} #{self.maternal_last_name} #{self.first_name}"
  end
end
