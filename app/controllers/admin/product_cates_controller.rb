class Admin::ProductCatesController < AdminController
	before_action :set_product_cate, only: [:destroy]

	def index
		@product_cate = ProductCate.new
		@product_cates = ProductCate.all
	end

	def show
		@product_cate = ProductCate.includes(:products).find(params[:id])
	end

	def create
		@product_cate = ProductCate.new(product_cate_params)
		@product_cate.save

		respond_to do |format|
			format.html { redirect_to :back }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_product_cate
			@product_cate = ProductCate.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def product_cate_params
			params.require(:product_cate).permit(:name)
		end
end
