class RegistrationsController < Devise::RegistrationsController
    def sign_up_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def account_update_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
    end
    
    # # For debugging
    # def create
    #   puts "SIGNUP PARAMS: #{sign_up_params.inspect}" # This will appear in your server logs
    #   super
    # end
  end