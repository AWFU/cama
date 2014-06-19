#encoding: utf-8
class ProductCatesController < ApplicationController
	def index
		@product_cate = ProductCate.first

		respond_to do |format|
			if(@product_cate)
				format.html { redirect_to product_cate_path(@product_cate) }
			else
				format.html { redirect_to root_path, :alert => "尚未建立產品分類" }
			end
		end		
	end

	def show
		@product_cates = ProductCate.all
		@product_cate = @product_cates.detect {|product_cate| product_cate.id == params[:id].to_i }

		@products = Product.front_show_by_cate(params[:id].to_i).all
	end
end