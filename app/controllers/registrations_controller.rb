class RegistrationsController < Devise::RegistrationsController

    #before_filter :redirect_if_unauthorized
    before_action :permit_invite_code

    private
  
    def permit_invite_code
        devise_parameter_sanitizer.for(:sign_up) << :invite_code
    end

    def redirect_if_unauthorized
      unless (current_user.present? && current_user.admin?)
        redirect_to root_path
      end
    end
  
    def sign_up_params
        params.require(:user).permit(:invite_code, :instructor, :name, :email, :password, :password_confirmation)
    end

    def account_update_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :instructor)
    end

end