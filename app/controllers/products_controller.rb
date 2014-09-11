#encoding: utf-8
class ProductsController < ApplicationController

  def show
    begin 
      @product = Product.includes(:galleries,:product_stocks).front_show_by_cate(params[:category_id].to_i).find_by_id(params[:id])
      if @product
        @product_cate = ProductCate.find(ProductCate.find(params[:category_id]).parent_id) 
      else
        redirect_to categories_path, notice: "找不到商品" and return
      end
      respond_to do |format|
        if(@product)
          #@product_cates = ProductCate.without_root_node
          @current_root = ProductCate.return_root_node
          @product_cates = ProductCate.get_level_hierarchy()

          cart_items = JSON.parse_if_json(cookies[:cart_cama]) || Hash.new
          @amount_in_cart = cart_items[@product.product_stocks.first.id.to_s] ||= 0
          #@product_cate = @product_cates.detect {|product_cate| product_cate.id == @product.product_cate_id }
          
          format.html
        else
          format.html { redirect_to category_path(params[:category_id]), alert: "找不到商品" }
        end
      end
    rescue
      redirect_to categories_path
    end
  end
end