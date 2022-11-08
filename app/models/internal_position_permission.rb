class InternalPositionPermission < ApplicationRecord
  belongs_to :internal_position
  belongs_to :permission
  belongs_to :unit, optional: true

  # FUNCION QUE ASIGNA UN PERMISO A UN INTERNAL POSITION
  # RECIBE EL NOMBRE DEL CARGO, LA NOMBRE DE LA TABLA SUBJECT CLASS Y EL NOMBRE
  # DE LA ACCION
  def self.assign_permission(internal_position_name,subject_class,action,unit_name=nil)
    #TODO asignar permiso con unidad
    unless Permission.where(subject_class:subject_class,action:action).first.nil?
      if unit_name.nil?
        unless InternalPositionPermission.exists?(internal_position:InternalPosition.find_by_name(internal_position_name),
                                                  permission:Permission.where(subject_class:subject_class,action:action).first,
                                                  unit:nil)
          InternalPositionPermission.new(internal_position:InternalPosition.find_by_name(internal_position_name),
                                         permission:Permission.where(subject_class:subject_class,action:action).first,
                                         unit:nil).save!
        end
      else
        unless InternalPositionPermission.exists?(internal_position:InternalPosition.find_by_name(internal_position_name),
                                                  permission:Permission.where(subject_class:subject_class,action:action).first,
                                                  unit:Unit.find_by_name(unit_name))
          InternalPositionPermission.new(internal_position:InternalPosition.find_by_name(internal_position_name),
                                         permission:Permission.where(subject_class:subject_class,action:action).first,
                                         unit:Unit.find_by_name(unit_name)).save!
        end


      end
    else
      permiso = Permission.new(subject_class:subject_class,action:action,name:action)
      permiso.save!
      if unit_name.nil?
        unless InternalPositionPermission.exists?(internal_position:InternalPosition.find_by_name(internal_position_name),
                                                  permission:permiso,
                                                  unit:nil)
          InternalPositionPermission.new(internal_position:InternalPosition.find_by_name(internal_position_name),
                                         permission:permiso,
                                         unit:nil).save!
        end

      else
        unless InternalPositionPermission.exists?(internal_position:InternalPosition.find_by_name(internal_position_name),
                                                  permission:permiso,
                                                  unit:Unit.find_by_name(unit_name))
          InternalPositionPermission.new(internal_position:InternalPosition.find_by_name(internal_position_name),
                                         permission:permiso,
                                         unit:Unit.find_by_name(unit_name)).save!
        end

      end
    end
  end
end
