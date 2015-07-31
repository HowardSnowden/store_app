class SessionsController < Devise::SessionsController  
    
    respond_to :json
    
      before_filter :assign_variable
      
      after_filter :order_redirect, :only => :create
    
    private
	def assign_variable
   	@cart = current_cart
	end
    
   
    
    def order_redirect
        
        if session[:last_action] == '/orders/new'
          response.location = session[:last_action]
          
     end 
    end
end   