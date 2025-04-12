module CurrentCart
    private
    
    def set_cart
      # Try to find cart in session
      @cart = Cart.find_by(id: session[:cart_id])
      
      # If no cart found or cart doesn't exist anymore, create a new one
      if @cart.nil?
        @cart = Cart.create
        session[:cart_id] = @cart.id
      end
      
      # If user is signed in, ensure cart is associated with user
      if user_signed_in? && session[:pending_cart_id].present?
        # Transfer items from pending cart to user's cart
        pending_cart = Cart.find_by(id: session[:pending_cart_id])
        if pending_cart.present?
          pending_cart.line_items.each do |item|
            # Add each product to the current cart
            current_item = @cart.add_product(item.product)
            # If item already existed, add quantities together
            current_item.quantity += (item.quantity - 1) if current_item.persisted?
            current_item.save
          end
          session.delete(:pending_cart_id)
          pending_cart.destroy
        end
      end
      
      # Remember current cart id in session
      session[:cart_id] = @cart.id
    end
    
    def store_location
      # Store cart id before authentication
      session[:pending_cart_id] = session[:cart_id] if session[:cart_id].present?
    end
  end