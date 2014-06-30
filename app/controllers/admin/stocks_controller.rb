class Admin::StocksController < AdminController
  before_action :set_stock, only: [:update ,:destroy]

  def index
    @stocks = ProductStock.by_product(params[:product_id]).all
    @stock = ProductStock.new
  end

  def create
    @stock = ProductStock.new(stock_params.merge({:product_id => params[:product_id]}))
    @stock.save

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def update
    @stock.update_attributes(stock_params) if @stock

    redirect_to :back
  end

  def destroy
    @stock.destroy if @stock

    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = ProductStock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.require(:product_stock).permit(:name, :amount, :assign_amount)
    end
end