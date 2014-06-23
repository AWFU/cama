#encoding: utf-8
class Useradmin::OrdersController < UseradminController
  def index
    @orders = current_user.orders.all
  end
  
  def show
    @order = current_user.orders.includes(:orderitems).includes(:orderlogs).find_by_id(params[:id])

    if(@order)
    	@orderask = @order.orderasks.new
    	@orderasks = Orderask.where(:order_id => @order.id)
    else
    	redirect_to useradmin_orders_path, alert: "找不到訂單"
    end
  end
end