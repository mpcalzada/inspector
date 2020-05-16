class Department < ApplicationRecord

  validates :description, presence: true

  has_many :degrees
end
