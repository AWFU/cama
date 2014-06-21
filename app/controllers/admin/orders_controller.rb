class Admin::OrdersController < AdminController
  def index
    @orders = Order.all
  end
  
  def show
    @order = Order.includes(:orderitems).find_by_id(params[:id])
  end
end