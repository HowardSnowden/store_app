class UserMailer < ActionMailer::Base
  default from: "phpemailaccess@gmail.com"
    
    def order_email(user, order)
    @order = order
    mail(:to => user.email,
         :subject => "Lugnuts Order Confirmation")
  end
end
