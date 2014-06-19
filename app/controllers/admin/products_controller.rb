class Admin::ProductsController < AdminController
  before_action :set_product_with_cate, only: [:show, :edit]
  before_action :set_product, only: [:update, :change_status, :destroy]

	def create
		@product_cate = ProductCate.find_by_id(params[:product_cate_id])
		@product = @product_cate.products.create

		respond_to do |format|
      format.html { redirect_to edit_admin_product_cate_product_path(@product_cate, @product) }
    end
	end

	def edit
		
	end

	def update
		@product.update(product_params)
		
		respond_to do |format|
			format.html { redirect_to admin_product_cate_product_path(@product.product_cate_id, @product) }
		end
	end

	def change_status
		@product.status = (@product.status == "enable") ? "disable" : "enable"
		@product.save

		respond_to do |format|
			format.html { redirect_to :back }
		end
	end

	def destroy
		@product.destroy
		
		respond_to do |format|
			format.html { redirect_to admin_product_cate_path(@product.product_cate_id) }
		end
	end

	private
    def set_product_with_cate
      @product = Product.includes(:product_cate).find_by_id(params[:id])
    end

    def set_product
      @product = Product.find_by_id(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :price_for_sale)
    end
end
