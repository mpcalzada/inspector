class Employer < ApplicationRecord
  belongs_to :degree

  # existing code

  has_attached_file :avatar,
                    :styles => {:medium => '300x300>', :thumb => '100x100#'},
                    :default_url => '/images/:style/missing_user.jpg'
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

end
