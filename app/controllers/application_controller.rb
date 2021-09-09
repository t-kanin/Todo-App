# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  acts_as_token_authentication_handler_for User
  before_action :authenticate_user!

  def authenticate_user_from_token!
    user_email = params[:email].presence
    user       = user_email && User.find_by_email(user_email)
    sign_in user, store: false if user && Devise.secure_compare(user.authentication_token, params[:authenticity_token])
  end
end
