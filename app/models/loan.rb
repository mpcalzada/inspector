class Loan < ApplicationRecord
  belongs_to :employer

  def formatted_interest
    (('%.2f' % self.interest).rjust(5, '0') + '%') unless self.interest.nil?
  end
end
