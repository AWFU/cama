class Useradmin::OrderasksController < UseradminController
  def create
    @order = Order.find_by_id(params[:id])
    @order.orderasks.create(orderask_params) if @order

    respond_to do |format| 
      format.html { redirect_to :back }
    end
  end

  private
    def orderask_params
      params.require(:orderask).permit(:description)
    end
end