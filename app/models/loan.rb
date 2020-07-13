class Loan < ApplicationRecord
  belongs_to :employer

  def self.active
    Loan.where(:paid => false)
  end

  def self.inactive
    Loan.where(:paid => true)
  end

  def formatted_interest
    (('%.2f' % self.interest_rate).rjust(5, '0') + '%') unless self.interest_rate.nil?
  end
end
