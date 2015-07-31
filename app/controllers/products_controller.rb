class ProductsController < ApplicationController
 
    before_filter :assign_variable

	
    def index
        
       if params[:productLine]
        
		@products = Product.where("\"productLine\" = ?", params[:productLine])
        @title = "Showing category '#{params[:productLine]}'"
           
        elsif params[:search]
        @products = Product.search(params[:search])
        @title = "Your search for '#{params[:search]}' returned #{@products.count} result(s)"
        else
           @products = Product.all
           @title =  "Showing all products"
        end
        
	end

	def show
        
		@product = Product.find(params[:id])
	end

	def new
        authorize! :new, Product
		@product = Product.new
	end

	def edit
        authorize! :edit, Product
		@product = Product.find(params[:id])
        authorize! :edit, @product
	end

	def create
        authorize! :create, Product
		@product = Product.new(product_params)

		if @product.save
			redirect_to @product 
		else
			render 'new'
		end
	end

	def update
        authorize! :update, Product
		@product = Product.find(params[:id])

		if @product.update(product_params)
			redirect_to @product 
		else
			render 'edit'
		end
	end

	def destroy
        authorize! :destroy, Product
		@product = Product.find(params[:id])
		@product.destroy

		redirect_to products_path
	end
	private


	def assign_variable
   	@cart = current_cart
	end


	def product_params
		params.require(:product).permit(:productCode, :productName, 
			:productLine, :productScale, :productVendor, :productDescription, 
			:quantityInStock, :buyPrice, :MSRP)
	end
end