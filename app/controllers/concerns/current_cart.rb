module CurrentCart
  extend ActiveSupport::Concern

  def set_cart
    # Try to find cart in session
    @cart = Cart.find_by(id: session[:cart_id])
    
    # If no cart found or cart doesn't exist anymore, create a new one
    if @cart.nil?
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
    
    # Handle cart association and item transfer for logged in users
    if user_signed_in?
      # If user has a cart associated with their account, use that instead
      user_cart = current_user.cart || Cart.create(user: current_user)
      
      # If there's a pending cart to merge OR the session cart is different from user's cart
      pending_cart_id = session[:pending_cart_id]
      session_cart_id = session[:cart_id]
      
      # We need to merge if:
      # 1. There's a pending cart from pre-login
      # 2. OR the current session cart is different from the user's associated cart
      if pending_cart_id.present? || (session_cart_id != user_cart.id && @cart.line_items.any?)
        source_cart = pending_cart_id.present? ? 
                      Cart.find_by(id: pending_cart_id) : 
                      @cart
        
        # Only proceed if source cart exists and has items
        if source_cart.present? && source_cart.line_items.any?
          # Transfer items from source cart to user's cart
          source_cart.line_items.each do |item|
            # Check if product already exists in user's cart
            existing_item = user_cart.line_items.find_by(product_id: item.product_id)
            
            if existing_item
              # Update quantity of existing item
              existing_item.quantity += item.quantity
              existing_item.save
            else
              # Create new line item in user's cart
              new_item = item.dup
              new_item.cart = user_cart
              new_item.save
            end
          end
          
          # Clean up source cart if it's not the user's cart
          if source_cart.id != user_cart.id
            source_cart.destroy
          end
        end
        
        # Clear pending cart reference
        session.delete(:pending_cart_id)
      end
      
      # Update session to use user's cart
      @cart = user_cart
      session[:cart_id] = user_cart.id
    end
  end
  
  def store_location
    # Store cart id before authentication only if user is not logged in
    unless user_signed_in?
      session[:pending_cart_id] = session[:cart_id] if session[:cart_id].present?
    end
  end
end