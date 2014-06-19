#encoding: utf-8
class ProductsController < ApplicationController
	def show
		@product_cates = ProductCate.all
		@product = Product.find_by_id(params[:id])

		@product_cate = @product_cates.detect {|product_cate| product_cate.id == @product.product_cate_id }
	end
end