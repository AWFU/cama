class Admin::OrderasksController < AdminController
  def index
    @orderasks = Orderask.includes(:order).all
  end

  def update
    @orderask = Orderask.find_by_id(params[:id])

    if(@orderask)
      @orderask.status = "done"
      @orderask.save
    end
    
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end
end