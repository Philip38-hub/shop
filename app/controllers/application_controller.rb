class ApplicationController < ActionController::Base
    include CurrentCart
    before_action :store_location, if: -> { request.get? && !user_signed_in? }
    protect_from_forgery with: :exception
    before_action :set_cart
    before_action :store_location, if: :devise_controller?
end