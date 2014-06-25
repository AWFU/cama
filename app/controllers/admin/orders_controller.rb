#encoding: utf-8
class Admin::OrdersController < AdminController
  def index
    @orders = Order.all
  end
  
  def show
    @order = Order.includes(:orderitems).find_by_id(params[:id])

    respond_to do |format|
      if(@order)
        format.html
        format.js
      else
        format.html { redirect_to :back, alert: "找不到訂單" }
      end
    end
  end
end