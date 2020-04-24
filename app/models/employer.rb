class Employer < ApplicationRecord
  belongs_to :degree

  # existing code

  has_attached_file :avatar,
                    :styles => {:medium => '300x300>', :thumb => '100x100#'},
                    :default_url => '/images/:style/missing_user.jpg'
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def self.current_employer(user_id)
    Employer.find_by_user_id(user_id)
  end

end
