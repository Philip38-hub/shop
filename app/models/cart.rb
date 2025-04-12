# app/models/cart.rb
class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy
    
    def add_product(product)
      line_item = line_items.find_by(product_id: product.id)
      
      if line_item
        line_item.quantity += 1
      else
        line_item = line_items.build(product_id: product.id, quantity: 1)
      end
      
      line_item
    end
    
    def total_price
      line_items.sum { |item| item.total_price }
    end
    
    def total_items
      line_items.sum(:quantity)
    end
  end