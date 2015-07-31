class PagesController < ApplicationController
  
    before_filter :assign_variable
    
  def index
    
  end

  def tips
    
  end

  def contact
    
  end

  def about
      
  end

  def articles
    
  end

  def videos
    
  end
    
    private
	def assign_variable
   	@cart = current_cart
	end
    
end
