module ProductsHelper
  def product_author(product)
    # Check if the product has a user (seller/creator)
    if product.user
      # Display the seller's name or email
      seller_name = product.user.name || product.user.email

      # Check if the current user is the creator of the product
      if current_user && current_user == product.user
        # If the current user is the creator, allow editing and deleting
        "#{seller_name} (You) - #{link_to 'Edit', edit_product_path(product)} | #{link_to 'Delete', product, method: :delete, data: { confirm: 'Are you sure?' }}".html_safe
      else
        # If the current user is not the creator, just show the seller's name
        seller_name
      end
    else
      # If no user is associated with the product (e.g., guest posts)
      "Unknown Seller"
    end
  end
end