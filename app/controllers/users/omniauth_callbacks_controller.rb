class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if !@user.nil?
      if @user.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect @user, event: :authentication
        #flash[:alert] = "User Logeado"
      else
        session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
        #@user.errors.full_messages.join("\n")
        redirect_to root_url, alert: @user.errors.full_messages.join("\n")
        flash[:alert] = "Usuario No registrado"
      end
    else
      redirect_to root_url, alert: "Su usuario no ha sido encontrado en el sistema. Por favor, contactese con proyectosinformaticos.fing@usach.cl"
      #flash[:alert] = "Su usuario no ha sido encontrado en el sistema. Por favor, contactese con proyectosinformaticos.fing@usach.cl"
    end
  end
end