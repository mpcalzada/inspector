class Provider < ApplicationRecord
  def full_address
    "#{self.city}, #{self.address}"
  end
end
