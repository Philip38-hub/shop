# This must be implemented.
# sign_up_params and account_update_params
class RegistrationsController < Devise::RegistrationsController
    # This is a key area to check - strong parameters must include :name
    def sign_up_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def account_update_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
    end
    
    # For debugging
    def create
      puts "SIGNUP PARAMS: #{sign_up_params.inspect}" # This will appear in your server logs
      super
    end
  end