class InternalPosition < ApplicationRecord
  has_many :internal_position_permissions
  has_many :permissions, through: :internal_position_permissions
  validates_uniqueness_of :name

  def has_permission?(permiso,unidad=nil)
    if unidad.nil?
      InternalPositionPermission.where(internal_position:self,permission:permiso,unit:nil).exists?
    else
      InternalPositionPermission.where(internal_position:self,permission:permiso,unit:unidad).exists?
    end
  end
end
