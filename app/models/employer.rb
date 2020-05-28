class Employer < ApplicationRecord
  belongs_to :degree
  has_one :employer_punctuation
  has_many :attendance_trackers


  # existing code

  has_attached_file :avatar,
                    :styles => {:medium => '300x300>', :thumb => '100x100#'},
                    :default_url => '/images/:style/missing_user.jpg'
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_attached_file :curriculum_vitae
  validates_attachment_content_type :curriculum_vitae, content_type: ['image/jpeg', 'image/png', 'image/gif', 'application/pdf']

  def self.current_employer(user_id)
    Employer.find_by_user_id(user_id)
  end

end
