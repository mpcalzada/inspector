class Address < ApplicationRecord
  has_many :journeys
  has_many :people

end
