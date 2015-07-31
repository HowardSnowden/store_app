module LineItemsHelper
    
def item_count(cart)
    s = 0
    cart.line_items.all.each do |t| 
        s = s + t.quantity
    end 
      s 
  end
end