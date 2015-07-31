class Product < ActiveRecord::Base
	validates :productCode, presence: true
    has_many :line_items
    has_many :orders, through: :line_items
    belongs_to :productlines
    before_destroy :ensure_not_referenced_by_any_line_item
    
  def self.search(query)
   
    where("\"productName\" like ?", "%#{query}%") 
  end
   
 def change_stock(amount)
     if self.quantityInStock > amount
     self.quantityInStock = self.quantityInStock - amount
     
     else
       false
    end
   end 
     
    
    
    private 
        
        def ensure_not_referenced_by_any_line_item
            if line_items.empty?
                return true
            else errors.add(:base, 'Line Items present')
                return false
            end 
        end
    
end
