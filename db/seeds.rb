# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# SEED INTERNAL POSITIONS
internal_positions = [
  "SUPERADMIN", "VISITANTE", "USUARIONORMAL" 
]
# SEED CONDITIONS
conditions = [
  "A dar de baja", "En Bodega de Excluidos", "Perdido", "Destruido"
]
#CREATE CONDITIONS 
conditions.each do |name|
  Condition.create(state_name: name) unless Condition.exists?(state_name: name)
end

# SEED UNITS
units = [
  "Departamento de Informatica", "Departamento de Electrica", "Departamento de Mecanica", "Departamento de Metalurgia"
]
#CREATE UNITS 
units.each do |name|
  Unit.create(name_unit: name, description_unit: name) unless Unit.exists?(name_unit: name, description_unit: name)
end


#CREATE INTERNALS POSITIONS
internal_positions.each do |name|
  InternalPosition.create(name: name) unless InternalPosition.exists?(name: name)
end
#PERMISOS
Permission.create(subject_class: "all", action: "manage", name:"manage") unless Permission.exists?(subject_class: "all", action: "manage", name:"manage")
Permission.create(subject_class: "Search", action: "index", name: "index") unless Permission.exists?(subject_class: "Search", action: "index", name: "index")
InternalPositionPermission.assign_permission("SUPERADMIN","all","manage")
InternalPositionPermission.assign_permission("VISITANTE","Welcome","index")
InternalPositionPermission.assign_permission("VISITANTE","Profile","change_user_profile")



InternalPositionPermission.assign_permission("USUARIONORMAL","Welcome","index")
InternalPositionPermission.assign_permission("USUARIONORMAL","Good","show_unit")
InternalPositionPermission.assign_permission("USUARIONORMAL","Office","show_office_unit")
InternalPositionPermission.assign_permission("USUARIONORMAL","Building","show_building_unit")
InternalPositionPermission.assign_permission("USUARIONORMAL","Unit","show")



InternalPositionPermission.assign_permission("USUARIONORMAL","Office","show_office_building")
InternalPositionPermission.assign_permission("USUARIONORMAL","Good","show_good_building")
InternalPositionPermission.assign_permission("USUARIONORMAL","Building","show")



InternalPositionPermission.assign_permission("USUARIONORMAL","Good","show_good_office")
InternalPositionPermission.assign_permission("USUARIONORMAL","Office","show")

InternalPositionPermission.assign_permission("USUARIONORMAL","Profile","change_user_profile")
InternalPositionPermission.assign_permission("USUARIONORMAL","Good","show")

InternalPositionPermission.assign_permission("USUARIONORMAL","DutyManager","get_current_user")
InternalPositionPermission.assign_permission("USUARIONORMAL","DutyManager","get_my_mybuildings")
InternalPositionPermission.assign_permission("USUARIONORMAL","DutyManager","get_my_offices")
InternalPositionPermission.assign_permission("USUARIONORMAL","DutyManager","get_my_goods")

InternalPositionPermission.assign_permission("USUARIONORMAL","Good","show_good_user")
InternalPositionPermission.assign_permission("USUARIONORMAL","Office","show_office_user")
InternalPositionPermission.assign_permission("USUARIONORMAL","Building","show_building_user")
InternalPositionPermission.assign_permission("USUARIONORMAL","Good","show_my_good")
InternalPositionPermission.assign_permission("USUARIONORMAL","Good","update")
InternalPositionPermission.assign_permission("USUARIONORMAL","ConditionGood","create")
InternalPositionPermission.assign_permission("USUARIONORMAL","ConditionGood","update")
InternalPositionPermission.assign_permission("USUARIONORMAL","Office","show_my_office")
InternalPositionPermission.assign_permission("USUARIONORMAL","Building","show_my_building")




