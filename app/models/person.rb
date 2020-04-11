class Person < ApplicationRecord
  belongs_to :address

  has_many :clients
  has_many :employers
end
