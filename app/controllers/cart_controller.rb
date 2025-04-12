class CartsController < ApplicationController
    include CurrentCart
    
    before_action :set_cart, only: [:show, :destroy]
    rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  
    def show
    end
  
    def destroy
      @cart.destroy if @cart.id == session[:cart_id]
      session[:cart_id] = nil
      redirect_to root_path, notice: "Your cart has been emptied"
    end
  
    private
    
    def invalid_cart
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to root_path, notice: "Invalid cart"
    end
  end