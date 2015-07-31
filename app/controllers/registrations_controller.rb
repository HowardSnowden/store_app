class RegistrationsController < Devise::RegistrationsController  
    
    
    respond_to :json
    
  before_filter :assign_variable

	private
	def assign_variable
   	@cart = current_cart
	end
    


    
end 