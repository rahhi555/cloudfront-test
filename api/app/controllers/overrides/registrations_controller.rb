module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    private

    def sign_up_params
      params.require(:registration).permit(:name, :email, :tel, :postal, :address, :password, :password_confirmation, :type)
    end

    def account_update_params
      params.permit(:name, :email, :tel, :postal, :address)
    end
  end
end
