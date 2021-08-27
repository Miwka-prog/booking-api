class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def current_token
    request.env['warden-jwt_auth.token']
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email first_name last_name birth_date])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[email])
  end
end
