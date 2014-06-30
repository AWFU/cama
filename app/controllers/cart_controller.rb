#encoding: utf-8
class CartController < ApplicationController
  require "cart"
  include CartHelper
  include OrdersHelper

  layout "cart"
  
  before_action :record_login_redirect_path, :only => [:check]
  before_action :authenticate_user!, :only => [:check, :create, :post_order]

  def index
    @order_items = Cart.check_items_in_cart(cookies[:cart_cama], "for_cart")
  end

  def check
    @order = Order.new
    @order_items = Cart.check_items_in_cart(cookies[:cart_cama], "for_cart")

    redirect_to cart_index_path, alert: "購物車內沒有商品" if @order_items.length == 0
  end

  def create
    @order = current_user.orders.new(order_params)

    respond_to do |format|
      if(@order.save)
        User.update_info_on_order_create(current_user, params)
        Orderitem.record_orderitems(@order, cookies[:cart_cama])

        if(params[:order][:payment_type] == "credit_card")
          format.html { redirect_to post_order_cart_index_path(@order) }
        else
          format.html { redirect_to finish_cart_index_path }
        end
      else
        format.html { render action: "check"}
      end
    end
  end

  def post_order
    @order = current_user.orders.includes(:orderitems).find_by_id(params[:id])
  end

  def receive_result
    @order = Order.includes(:orderitems).find_by_ordernum(params[:ONO])
    @ordersum = sum_order_items(@order.orderitems) + get_shipping_fee

    if(params[:RC] == "00" && params[:M] == get_esun_key(@order.ordernum, @ordersum))
      @order.update_progress
    end

    redirect_to finish_cart_index_path
  end

  def finish
    cookies.delete(:cart_cama)
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
    @result = Cart.plus_stock(cookies[:cart_cama], params[:id])
    cookies[:cart_cama] = @result[:cart_items]
    @cart_message = @result[:cart_message]

    respond_to do |format|
      format.html { redirect_to cart_index_path, alert: @cart_message }
    end
  end

  def minus
    @result = Cart.minus_stock(cookies[:cart_cama], params[:id])
    cookies[:cart_cama] = @result[:cart_items]
    @cart_message = @result[:cart_message]

    respond_to do |format|
      format.html { redirect_to cart_index_path }
    end
  end

  def delete
    @result = Cart.delete_stock(cookies[:cart_cama], params[:id])
    cookies[:cart_cama] = @result[:cart_items]
    @cart_message = @result[:cart_message]

    respond_to do |format|
      format.html { redirect_to cart_index_path }
    end
  end

  private
    def order_params
      params.require(:order).permit(:buyer_name, :buyer_tel, :receiver_name, :receiver_tel, :receiver_address, :payment_type)
    end
end