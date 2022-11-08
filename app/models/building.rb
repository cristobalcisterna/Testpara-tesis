class Building < ApplicationRecord
  belongs_to :duty_manager
  belongs_to :unit
  has_many :offices
end
