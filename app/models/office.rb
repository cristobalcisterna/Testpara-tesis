class Office < ApplicationRecord
  belongs_to :duty_manager
  belongs_to :building
end
