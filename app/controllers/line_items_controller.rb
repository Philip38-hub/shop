class LineItemsController < ApplicationController
    include CurrentCart
    
    before_action :set_cart, only: [:create]
    before_action :set_line_item, only: [:destroy, :increase, :decrease]
  
    def create
      return head :unprocessable_entity unless params[:product_id]
      
      product = Product.find(params[:product_id])
      @line_item = @cart.add_product(product)
  
      respond_to do |format|
        if @line_item.save
          @cart.reload # Ensure we have the latest cart data
          format.html { redirect_back(fallback_location: root_path, notice: "Added to your cart") }
          format.js
        else
          logger.error "Failed to save line item: #{@line_item.errors.full_messages.join(', ')}"
          format.html { redirect_back(fallback_location: root_path, alert: "Could not add to cart: #{@line_item.errors.full_messages.join(', ')}") }
          format.js { render js: "alert('Could not add to cart: #{@line_item.errors.full_messages.join(', ')}');", status: :unprocessable_entity }
        end
      end
    end
  
    def destroy
      @cart = @line_item.cart
      @line_item.destroy
      
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path, notice: "Removed from your cart") }
        format.js
      end
    end
    
    def increase
      @cart = @line_item.cart
      @line_item.quantity += 1
      
      respond_to do |format|
        if @line_item.save
          format.html { redirect_back(fallback_location: root_path) }
          format.js
        else
          format.html { redirect_back(fallback_location: root_path, alert: "Could not update quantity") }
          format.js
        end
      end
    end
    
    def decrease
      @cart = @line_item.cart
      
      if @line_item.quantity > 1
        @line_item.quantity -= 1
        @line_item.save
      else
        @line_item.destroy
      end
      
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.js
      end
    end
  
    private
    
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end
  end