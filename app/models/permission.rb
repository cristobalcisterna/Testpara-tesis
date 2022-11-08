class Permission < ApplicationRecord
  has_many :internal_position_permissions
  has_many :internal_positions, through: :internal_position_permissions

end
