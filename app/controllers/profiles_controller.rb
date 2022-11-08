class ProfilesController < ApplicationController
  def change_user_profile
    if !params[:id].nil? && !params[:active_profile].nil?
      usuario = User.find(params[:id])
      unless usuario.nil?
        usuario.update(active_profile:UserInternalPosition.where(user_id:usuario.id,internal_position_id: params[:active_profile]).last.internal_position_id)
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def permission_params
    params.permit(:id, :active_profile)
  end
end
