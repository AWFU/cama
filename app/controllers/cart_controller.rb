#encoding: utf-8
class CartController < ApplicationController
  require "cart"
  layout "cart"

  def index
    @order_items = Cart.check_items_in_cart(cookies[:cart_cama])
  end

  def check
    
  end

  def finish
    
  end

  def add
    if(params[:cart][:amount].to_i > 0)
      @stock = ProductStock.find_by_id(params[:cart][:stock])
      
      if(@stock)
        @result = Cart.check_stock(cookies[:cart_cama], @stock, params[:cart][:amount].to_i)

        cookies[:cart_cama] = @result[:cart_items]
        @cart_message = @result[:cart_message]
      else
        @cart_message = "找不到商品"
      end
    else
      @cart_message = "請輸入正確數量"
    end

    respond_to do |format|
      format.html { redirect_to :back, notice: @cart_message }
    end
  end

  def plus
    
  end

  def minus
    
  end

  def delete
    
  end
end