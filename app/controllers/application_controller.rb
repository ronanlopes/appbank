class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  respond_to :html, :xml, :json, :js

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def index

  end

  protected

    def configure_permitted_parameters
        # Fields for sign up
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:nome, :email, :password, :password_confirmation) }
        # Fields for editing an existing account
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:nome, :email, :password, :password_confirmation, :current_password)}
    end

end
