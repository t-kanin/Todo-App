# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # Disable CSRF protection
  skip_before_action :verify_authenticity_token

  # Be sure to enable JSON.
  respond_to :html, :json

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?

    respond_with resource, location: after_sign_in_path_for(resource) do |format|
      format.json { render json: { user_email: resource.email, access_token: resource.access_token } }
    end
  end
end
