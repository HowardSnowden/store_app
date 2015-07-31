class Order < ActiveRecord::Base
   has_many :line_items, dependent: :destroy
    
    PAYMENT_TYPES = [ "Stripe" ]
    
    validates :name, :address, :email, presence: true
    validates :pay_type, inclusion: PAYMENT_TYPES
    
    def add_line_items_from_cart(cart)
        cart.line_items.each do |item|
            item.cart_id = nil
            line_items << item
        end 
    end 
        
    def order_total
        total = 0
        self.line_items.each do |item|
            total += item.quantity * item.product.MSRP
        end 
        total
      end 
   def subtract_order_from_stock
       enough = true
       self.line_items.each do |item|
           product = Product.find(item.product.id)
           if product.change_stock(item.quantity)
           product.save
           else 
             enough = false
           end 
        end 
         enough 
       end
           
     
end
