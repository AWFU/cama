#encoding: utf-8
class ProductsController < ApplicationController
	def show
		@product = Product.includes(:product_stocks).front_show_by_cate(params[:product_cate_id].to_i).find_by_id(params[:id])

		respond_to do |format|
			if(@product)
				@product_cates = ProductCate.all
				@product_cate = @product_cates.detect {|product_cate| product_cate.id == @product.product_cate_id }
				
				format.html
			else
				format.html { redirect_to :back, alert: "找不到商品" }
			end
		end
	end
end