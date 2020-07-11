class LoanHistory < ApplicationRecord
  module Payment
    MONTHLY_PAYMENT = 1
    PREPAYMENT = 2
    PENALIZATION = 3
  end
end
