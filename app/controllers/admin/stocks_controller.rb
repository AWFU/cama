class Admin::StocksController < AdminController
	def index
		@stocks = ProductStock.by_product(params[:product_id]).all
	end
end