class UserInternalPosition < ApplicationRecord
  belongs_to :internal_position
  belongs_to :user
end
