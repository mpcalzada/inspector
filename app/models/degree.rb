class Degree < ApplicationRecord

  validates :description, :department_id, presence: true

  has_many :employers
  belongs_to :department
end
