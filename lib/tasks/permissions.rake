namespace 'permissions' do
  desc "Loading all models and their related controller methods inpermissions table."
  task(:permissions => :environment) do
    puts "CARGANDO PERMISOS Y ACCIONES"
    arr = []
    #load all the controllers
    controllers = Dir.new("#{Rails.root}/app/controllers").entries
    controllers.each do |entry|
      if entry =~ /_controller/
        #check if the controller is valid
        arr << entry.camelize.gsub('.rb', '').constantize
      elsif entry =~ /^[a-z]*$/ #namescoped controllers
        Dir.new("#{Rails.root}/app/controllers/#{entry}").entries.each do |x|
          if x =~ /_controller/ && entry!="admin"
            arr << "#{entry.titleize}::#{x.camelize.gsub('.rb', '')}".constantize
          end
        end
      end
    end

    arr.each do |controller|
      #only that controller which represents a model
      if controller.permission
        #create a universal permission for that model. eg "manage User" will allow all actions on User model.
        write_permission(controller.permission, "manage", 'manage') #add permission to do CRUD for every model.
        controller.action_methods.each do |method|
          if method =~ /^([A-Za-z\d*]+)+([\w]*)+([A-Za-z\d*]+)$/ #add_user, add_user_info, Add_user, add_User
            name, cancan_action = eval_cancan_action(method)
            write_permission(controller.permission, cancan_action, name)
          end
        end
      end
    end
    puts "FINALIZADO PERMISSIONS"
  end
##########



#PERMISOS BASICOS
desc "persmisos basicos"
task basicos: :environment do
  puts "CARGANDO PERMISOS BASICOS"
  nombres_internal = ["USUARIONORMAL", "VISITANTE"]
  nombres_internal.each do |nombre_internal|
            
    InternalPositionPermission.assign_permission(nombre_internal,"Welcome","index")
    InternalPositionPermission.assign_permission(nombre_internal,"Profile","change_user_profile")
  end
  InternalPositionPermission.assign_permission("SUPERADMIN","all","manage")

  puts "PERMISOS BASICOS CARGADOS"
end





  #EJEMPLO PARA AÑADIR PERMISOS A UN CARGO EN ESPECIFICO
   desc "Cargos para encargados de bienes de la plataforma"
   task encargado_bienes: :environment do
     nombres_internal = ["USUARIONORMAL"]
     puts "CARGANDO PERMISOS PARA USUARIOS ENCARGADOS DE BIENES"
     nombres_internal.each do |nombre_internal|
  #FUNCIÓN QUE AÑADE LOS PERMISOS A LA TABLA INTERMEDIA

  #PESTAÑA DE SUBIDA MASIVA A DRIVE
  if (nombre_internal == "USUARIONORMAL")
    InternalPositionPermission.assign_permission("USUARIONORMAL","Welcome","index")
    InternalPositionPermission.assign_permission("USUARIONORMAL","Good","show_unit")
    InternalPositionPermission.assign_permission("USUARIONORMAL","Office","show_office_unit")
    InternalPositionPermission.assign_permission("USUARIONORMAL","Building","show_building_unit")
    InternalPositionPermission.assign_permission("USUARIONORMAL","Unit","show")
    InternalPositionPermission.assign_permission("USUARIONORMAL","Unit","show_active_unit")
    
    
    
    
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
  end






      
     end
   end
###########
end

#this method returns the cancan action for the action passed.
def eval_cancan_action(action)
  name = action.to_s
  cancan_action = action.to_s
  return name, cancan_action
end

#check if the permission is present else add a new one.
def write_permission(model, cancan_action, name)
  permission = Permission.where(subject_class: model, action: cancan_action).first
  unless permission
    permission = Permission.new
    permission.name = name
    permission.subject_class = model
    permission.action = cancan_action
    permission.save
  end
end