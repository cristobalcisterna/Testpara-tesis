class User < ApplicationRecord
  devise :database_authenticatable, :recoverable,
         :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :user_internal_positions
  has_many :internal_positions, through: :user_internal_positions
  has_many :permissions, through: :internal_positions
  validates_uniqueness_of :email
  
  
  def self.from_omniauth(access_token)
    data = access_token.info
    #HABILITAR BUSQUEDA DE USUARIO EN TABLA USUARIO SI NO SE CUENTA CON CREDENCIALES SIGA 
    user = User.where(email: data['email']).first
    #user = nil
    #AGREGAR ENLACE CON SIGA
    #MODIFICAR CREDENCIALES Y RUTA DE ACCESO
    #res = HTTParty.get('http://localhost:9000/siga/api/v1/users',
    #                        format: :json, headers: { 'apikey' => 'DbFRAPbFaxqop5r4l1dvJaZD' },
    #                        query: { 'email' => data['email'] })
    #if !res.blank? && !res["id"].blank? && !res["disabled"]
    #  user = User.find(res["id"])
    #  unless user.blank?
    #    user.update(avatar_url: data['image'])
    #  end
    #end


    # Uncomment the section below if you want users to be created if they don't exist
    # unless user
    #     user = User.create!(
    #        full_name: data['name'],
    #        email: data['email'],
    #        avatar_url: data['image'],
    #        password: Devise.friendly_token[0,20]
    #     )
    # end
    #
    user
  end

  # FUNCIÓN DE CLASE
  # FUNCIÓN QUE CREA UN USUARIO DENTRO DEL SISTEMA
  # @param [String] correo ; CORREO DEL USUARIO A CREAR
  # @return [void] SIN RETORNO, SI NO ES POSIBLE GUARDAR, LANZA ERROR
  def self.create_user(correo)
    if User.find_by_email(correo)
      usuario = User.find_by_email(correo)
    else
      password_length = 16
      password = Devise.friendly_token.first(password_length)
      usuario =  User.new(email: correo,
                          password: password)
      usuario.save!
    end
  end

  # FUNCIÓN QUE RETORNA EL CARGO PRINCIPAL DE UN USUARIO
  # @return [InternalPosition] RETORNA UN INTERNAL POSITION QUE CORRESPONDE
  # AL QUE ESTÁ SETEADO COMO ACTIVO, O EL PRIMERO, PODRÍA SER NULL
  def cargo_principal
    if active_profile.nil?
      self.internal_positions.first
    else
      InternalPosition.find(active_profile)
    end
  end

  # FUNCIÓN DE CLASE
  # FUNCIÓN QUE ASIGNA UN CARGO A UN USUARIO SEGÚN SU EMAIL
  # @param [String] correo ; CORREO DEL USUARIO A CREAR O ASIGNAR
  # @param [String] nombre_cargo ; NOMBRE DEL CARGO A ASGINAR AL USUARIO
  # @param [String] unidad ; NOMBRE DE LA UNIDAD A ASGINAR EL CARGO
  # @return [void]
  def self.asignar_cargo(correo,auxrut,nombre,nombre_cargo,unidad=nil)
    #TODO INTEGRAR CARGO CON UNIDAD
    #unless unidad.nil?
    #  unidad = Unit.find_by_name(unidad).id
    #end
    if User.find_by_email(correo)
      usuario = User.find_by_email(correo)
    else
      password_length = 16
      password = Devise.friendly_token.first(password_length)
      usuario =  User.new(email: correo, password: password, rut: auxrut, full_name: nombre)
      usuario.save!
    end
    cargo = InternalPosition.find_by_name(nombre_cargo)
    if !usuario.blank? && !cargo.blank?
      if UserInternalPosition.exists?(user:usuario,internal_position:cargo)
        user_internal_position = UserInternalPosition.where(user:usuario,internal_position:cargo).first
      else
        user_internal_position = UserInternalPosition.new(user:usuario,internal_position:cargo)
        user_internal_position.save
      end
      usuario.update!(active_profile:user_internal_position.id)
    end
  end

  def has_permission?(nombre_tabla,nombre_accion,unidad)
    permiso = Permission.where(subject_class: nombre_tabla,action: nombre_accion).first_or_initialize
    permiso_manage = Permission.where(subject_class: nombre_tabla,action: "manage").first_or_initialize
    permiso_super_usuario = Permission.where(subject_class: "all",action: "manage").first_or_initialize
    unless self.active_profile.nil?
      if self.cargo_principal.has_permission?(permiso_manage, unidad) ||
        self.cargo_principal.has_permission?(permiso, unidad) ||
        self.cargo_principal.has_permission?(permiso_super_usuario, unidad) ||
        self.cargo_principal.has_permission?(permiso_super_usuario, nil)
        return true
      end
    end
    false
  end


  
end
