module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    before_action :configure_permitted_parameters

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i(name tel post_code address type))
      devise_parameter_sanitizer.permit(:account_update, keys: %i(name tel post_code address type))
    end
  end
end