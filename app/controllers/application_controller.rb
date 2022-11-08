class ApplicationController < ActionController::Base
    protect_from_forgery prepend: true
    before_action :authenticate_user!
    before_action :authorize_action
    skip_before_action :authorize_action, if: :devise_controller?

    private
    #TODO IMPLEMENTAR SEGUN NECESIDADES DE PROYECTO CON CONSULTAS API
    #
    def authorize_action
        if !current_user.nil? && params[:controller] != 'devise/sessions'
            #TODO INTEGRAR FILTRO POR UNIDAD
            if current_user.cargo_principal===InternalPosition.find_by_name("SUPERADMIN")
                unidad = nil
            else
                #unidad = current_user.unidad_principal
                unidad = nil
            end
            controller_name_getted = controller_name.singularize.camelize
            #EJEMPLO CUANDO EL PLURAR DEL CONTROLADOR NO SE SINGULARIZA
            # DE MANERA CORRECTA
            #if controller_name_getted == "LoadDatum"
            #    controller_name_getted = "LoadData"
            #end
            unless current_user.has_permission?(controller_name_getted,action_name,unidad)
                respond_to do |format|
                    format.json { head :forbidden, content_type: 'text/html' }
                    format.html { redirect_to "/403" }
                    format.js   { head :forbidden, content_type: 'text/html' }
                end
            end
        end
    end

    protected

    #derive the model name from the controller. egs UsersController will return User
    def self.permission
        return self.name.gsub('Controller','').singularize.split('::').last.constantize.name rescue nil
    end

end
