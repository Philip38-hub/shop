class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
end

class ApplicationController < ActionController::Base
    include CurrentCart
    
    before_action :store_location, if: :devise_controller?
  end