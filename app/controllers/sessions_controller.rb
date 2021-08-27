class SessionsController < Devise::SessionsController
  respond_to :json

  respond_to :json

  # POST /users/sign_in
  # Specs No
  def create
    # Check both because rspec vs normal server requests .... do different things? WTF.
    possible_aud = request.headers['HTTP_JWT_AUD'].presence || request.headers['JWT_AUD'].presence

    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    if user_signed_in?
      last = resource.allowlisted_jwts.where(aud: possible_aud).last
      aud = possible_aud || 'UNKNOWN'
      if last.present?
        last.update_columns({
                              browser_data: params[:browser],
                              os_data: params[:os],
                              remote_ip: params[:ip]
                            })
        aud = last.aud
      end
      respond_with(resource, { aud: aud })
    else
      render json: resource.errors, status: :unauthorized
    end
  rescue StandardError
    render json: { error: I18n.t('api.oops') }, status: :internal_server_error
  end

  private

  def current_token
    request.env['warden-jwt_auth.token']
  end

  def respond_with(resource, opts = {})
    render json: {
      user: resource.for_display,
      jwt: current_token,
      aud: opts[:aud]
    }
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: { message: 'You are logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Hmm nothing happened.' }, status: :unauthorized
  end
end
