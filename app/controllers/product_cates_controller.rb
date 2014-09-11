#encoding: utf-8
class ProductCatesController < ApplicationController
  def index
    @product_cate = ProductCate.without_root_node.first

    respond_to do |format|
      if(@product_cate)
        format.html { redirect_to category_path(@product_cate) }
      else
        format.html { redirect_to root_path, :alert => "找不到此產品分類" }
      end
    end   

  end

  def show
    begin 
      @current_root = ProductCate.return_root_node
      @product_cates = ProductCate.get_level_hierarchy()

      @product_cates_all = ProductCate.includes(:galleries)
      @product_cate = @product_cates_all.detect {|product_cate| product_cate.id == params[:id].to_i }
      
      redirect_to categories_path and return if @product_cate.nil?
      
      @parent_cate = ProductCate.find(@product_cate.parent_id)
      @products = Product.front_show_by_cate(params[:id].to_i)
    rescue
      redirect_to categories_path
    end
  end
end