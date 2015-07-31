module ApplicationHelper
	def full_title(page_title = '')
		base_title = "Lugnuts Auto Parts"
		if page_title.empty?
			base_title
		else
			"#{page_title} - #{base_title}"
		end
	end
    
 def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
    
   def hidden_div_if(condition, attributes= {}, &block)
       
       if condition
           attributes["style"] = "display: none"
        end 
       
        content_tag("div", attributes, &block)
       
   end 
    
end
