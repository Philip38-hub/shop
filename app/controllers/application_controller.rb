class ApplicationController < ActionController::Base
    include CurrentCart
    protect_from_forgery with: :exception
    before_action :set_cart
    before_action :store_location, if: :devise_controller?
end