# App Base
Aplicación Base

Descripción:
Está aplicación base contiene lo necesario para inicializar una aplicación de servicio básico para los proyectos TI de la USACH. Dentro de sus características se encuentran.
- Vista de inicio
- Acceso a través de google en base a usuarios usach #CONFIGURAR CREDENCIALES #CONFIGURAR PUNTO DE ACCESO API GATEWAY
- Manejo de usuarios con devise, una vez logueado, redirige a una vista inicial
- Acceso en base a roles y permisos #PRE-ESTABLECIDOS: SUPERADMIN - VISITANTE
- Paquetes para front y back ya instalados, como gemas oracle o devise, o vue, buefy etc... pueden ser revisados en el gemfile y el package.json respectivamente

Instrucciones de instalación:
- yarn install
- bundle
- bundle exec figaro install
- Configurar variables de entorno para acceso google y BD, config/database.yml y /config/application.yml

ORACLE_USERNAME : "your_app_username"
ORACLE_PASSWORD : "your_app_password"
GOOLE_AUTH_USER: '921981601478-8o9iajotrbh288f4o8g9s7hfiasxxxxx.apps.googleusercontent.com'
GOOGLE_AUTH_KEY: 'GOCSPX-tuKJxLiUMr5DlXv2zIlCJAPxxxx'

- rails db:migrate
- rails db:seed
- rails permissions:permissions

Si no posee un usuario creado en SIGA o las credenciales para acceder a la API Gateway, debe cambiarse en User.rb la función from_omniauth para que lea los usuarios de la BD local.
Para crear un usuario de manera local, utilizar la siguiente función
- User.asignar_cargo("cristobal.cisterna@usach.cl","SUPERADMIN")
- User.asignar_cargo("cristobal.cisterna@usach.cl","VISITANTE")
- User.asignar_cargo("cristobal.cisterna@usach.cl","UNIDADENCARGADO")
- User.asignar_cargo("emailprueba@gmail.cl","12345678-9","Nombre Prueba","USUARIONORMAL")

- User.asignar_cargo("tucorreo@usach.cl","VISITANTE") 

Para montar la aplicación:
- rails s

Cosas para hacer en tu aplicación y para tener en cuenta:
- Buscar en todo el código nombre aplicación base y cambiar por nombre de su aplicación
- Implementar variante unidad a los permisos



