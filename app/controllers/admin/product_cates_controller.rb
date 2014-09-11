#encoding: utf-8
class Admin::ProductCatesController < AdminController
  authorize_resource
  before_action :set_product_cate, only: [:update ,:destroy]

  def index
    @product_cate = ProductCate.new
    @product_cates = ProductCate.for_admin.where("depth = 1")
  end

  def show
    @product_cate = ProductCate.includes(:products).find(params[:id])
    @product_cates = ProductCate.where("parent_id = #{@product_cate.id}")
    @new_cate = ProductCate.new
    @breadcrumb = @product_cate.find_my_direct_parent
  end

  def create

    @product_cate = ProductCate.new(product_cate_params)
    @product_cate.save

    if params[:filename].present? 
      display_name = params[:filename]
    else 
      display_name = "#{@product_cate.name}-CATEGORY-#{@product_cate.galleries.count + 1}"
    end
      
    @latestAttach = CategoryCoverGallery.create(:attachment => params[:attachment], :attachable => @product_cate, :file_name => display_name) if params[:attachment]


    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def update

    if params[:filename].present? 
      display_name = params[:filename]
    else 
      display_name = "#{@product_cate.name}-CATEGORY-#{@product_cate.galleries.count + 1}"
    end
      
    @latestAttach = CategoryCoverGallery.create(:attachment => params[:attachment], :attachable => @product_cate, :file_name => display_name) if params[:attachment]
    
    @product_cate.update_attributes(product_cate_params) if @product_cate

    redirect_to :back
  end

  def destroy

    #@product_cate.destroy if @product_cate && @product_cate.products.count == 0
    
    flash[:alert] = "此分類下仍有產品 無法刪除" if @product_cate.products.count > 0
    
    deletable = true
    # prevent delete by mistake
    ProductCate.where(id: @product_cate.descendents).each do |category|
      if category.products.count > 0
        flash[:alert] = "分類 [#{category.name}] 下仍有產品 無法刪除"
        deletable = false
        break
      end
    end
    
    @product_cate.destroy if deletable == true
    
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_cate
      @product_cate = ProductCate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_cate_params
      params.require(:product_cate).permit(:name, :parent_id, :depth, :attachment)
    end
end
