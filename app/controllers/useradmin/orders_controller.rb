#encoding: utf-8
class Useradmin::OrdersController < UseradminController
  def index
    @orders = current_user.orders.all
  end
  
  def show
    @order = current_user.orders.includes(:orderitems).find_by_id(params[:id])
    redirect_to user_orders_path, alert: "找不到訂單" unless @order
  end
end