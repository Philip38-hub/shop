class CartsController < ApplicationController
  include CurrentCart
  
  before_action :set_cart, only: [:show, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def show
    @line_items = @cart.line_items.includes(:product).order(created_at: :desc)
    respond_to do |format|
      format.html
      format.js
    end
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