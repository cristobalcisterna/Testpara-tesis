class ErrorsController < ApplicationController
  skip_before_action :authorize_action
  protect_from_forgery with: :null_session

  def not_found
    render(status: 404)
  end
  def internal_error
    render(status: 500)
  end
  def authorization_required
    render :status => 401
  end

end
