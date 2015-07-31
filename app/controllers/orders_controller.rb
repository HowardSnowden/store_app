class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :fill_order, :edit, :update, :destroy]
  respond_to :html

  def index
    authorize! :index, Order
    @orders = Order.all
    respond_with(@orders)
    
  end

  def show
    authorize! :show, Order
    respond_with(@order)
  end

  def new
    @redirect_vars = {sendto:'', message: ''}
    @cart = current_cart
    
    if !(order_request_proper?)
        redirect_to @redirect_vars[:sendto], notice: @redirect_vars[:message]
        session[:last_action] = "/orders/new"
        return
    end 
    
#    if @cart.line_items.empty?
#        redirect_to root_url, notice: "Your cart is empty"
#        return 
#    end 
      @order = Order.new
    respond_to do |format|
        format.html
        format.json {render json: @order }
     end 
  end

  def edit
  end

  def create
    @cart = current_cart
     @order = Order.new(order_params)
     @order.add_line_items_from_cart(@cart)
     @order.card_token = params[:stripeToken]
      customer = Stripe::Customer.create(
        :email => @order.email,
        :card  => @order.card_token
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => (@cart.total_price*100).to_i,
        :description => 'Lugnuts Purchase',
        :currency    => 'usd'
      )
      respond_to do |format|
      if @order.save
          Cart.destroy(session[:cart_id])
          session[:cart_id] = nil
          UserMailer.order_email(current_user, @order).deliver
        format.html { redirect_to(root_url, :notice => 
          "Thank you for your order. An confirmation e-mail has been sent to #{current_user.email} ") }
        
      else
        @cart = current_cart
        format.html { render :action => "new" }
      
      
       end 
     end 
    rescue Stripe::CardError => e
      flash[:error] = e.message
      render :new
end
  

  def update
    @order.update(order_params)
    respond_with(@order)
  end

  def destroy
    @order.destroy
    respond_with(@order)
  end

  def order_request_proper?
      
      if @cart.line_items.empty?
          @redirect_vars[:sendto] = root_url
          @redirect_vars[:message] = 'Your cart is empty'
        return false
      elsif  !(user_signed_in?)
          @redirect_vars[:sendto] = new_user_session_path
          @redirect_vars[:message] = 'You must sign in to place your order'
        return false
      end 
        true
    end
      
  def fill_order
      fill_order = true
      authorize! :update, Order
      if @order.subtract_order_from_stock && @order.status == 'pending'
          @order.status = 'Shipped'
       else 
         fill_order = false
       end 
      
      if @order.save && fill_order
          redirect_to orders_path, :notice => "Order status changed to 'shipped'!"
      else 
          flash.now[:error] = "Not enough product to fill order or order has been shipped already"
          render :show
      end
  end 

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type, :card_token, :status)
    end

    def stripe_params
      params.permit :stripeEmail, :stripeToken
    end
    

end
