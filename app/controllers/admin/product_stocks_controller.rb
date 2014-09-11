class Admin::ProductStocksController < AdminController
  authorize_resource
  before_action :set_stock, only: [:update ,:destroy]

  def index
    @product_stocks = ProductStock.by_product(params[:id]).all
    @product_stock = ProductStock.new

    
    @product = Product.find_by_id(params[:id])
    @product_cate = @product.product_cate if @product
    
  end

  def create
    @product_stock = ProductStock.new(stock_params.merge({:product_id => params[:id]}))
    @product_stock.save

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def update
    @product_stock.update_attributes(stock_params) if @product_stock

    redirect_to :back
  end

  def destroy
    @product_stock.destroy if @product_stock

    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @product_stock = ProductStock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.require(:product_stock).permit(:name, :amount, :assign_amount)
    end
end