#encoding: utf-8
class CartController < ApplicationController
  require "cart"
  layout "cart"
  before_action :record_login_redirect_path, :only => [:check]
  before_action :authenticate_user!, :only => [:check, :create]

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
        if(params[:update_member_info] || params[:set_as_default_address])
          if(params[:update_member_info])
            current_user.username = params[:order][:buyer_name]
            current_user.tel = params[:order][:buyer_tel]
          end

          # if(params[:set_as_default_address])
          #   current_user.receiveaddress = params[:order][:receiveraddress]
          # end
          current_user.save
        end

        if(params[:add_to_addressbook])
          # @addressbook = current_member.addressbooks.new
          # @addressbook.address = params[:order][:receiveraddress]
          # @addressbook.save
        end

        Orderitem.record_orderitems(@order, cookies[:cart_cama])

        format.html { redirect_to finish_cart_index_path }
      else
        format.html { render action: "check"}
      end
    end
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