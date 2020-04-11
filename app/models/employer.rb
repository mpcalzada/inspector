class Employer < ApplicationRecord
  belongs_to :person
  belongs_to :degree
end
