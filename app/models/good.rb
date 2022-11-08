class Good < ApplicationRecord
  belongs_to :duty_manager
  belongs_to :office
  belongs_to :investment_type
  belongs_to :financial_source

end
