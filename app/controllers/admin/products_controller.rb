#encoding: utf-8
class Admin::ProductsController < AdminController
  authorize_resource
  
  before_action :set_product_with_cate, only: [:show, :edit ,:basic_info, :productphoto_upload, :taste_attributes, :free_paragraph, :create_product_attachment, :create_taste_attachment]
  before_action :get_product_cate, only: [:basic_info, :productphoto_upload, :taste_attributes, :free_paragraph]
  before_action :set_product, only: [:update, :change_status, :destroy]
  before_action :disable_product_when_edit, only: [:edit, :basic_info, :productphoto_upload, :taste_attributes, :free_paragraph, :create_product_attachment, :create_taste_attachment]
  
  def create

    @product = Product.create()
    @product.article = Article.new

    @product_cate = ProductCate.find_by_id(params[:product_cate_id])
    @product_cate.products << @product
    #@product_cate = ProductCate.find_by_id(params[:product_cate_id])
    #@product = @product_cate.products.create
    #@product.article = Article.new

    respond_to do |format|
      if( @product.errors.any? )
        format.html { redirect_to :back, alert: "新增失敗" }
      else
        @product.product_stocks.create
        format.html { redirect_to basic_info_admin_product_cate_product_path(@product_cate, @product) }
      end
    end
  end

  def edit
    #@product.update_attributes({:status => "disable"})
  end

  def update

    if params[:filename].present? 
      display_name = params[:filename] 
    else 
      display_name = "#{@product.name}-TASTE-#{@product.galleries.count + 1}"
    end
    @latestAttach = TasteAttributeGallery.create(:attachment => params[:attachment], :attachable => @product, :file_name => display_name) if params[:attachment]

    @product.update(product_params.merge({:status => "enable"})) && ( params[ :article ].nil? ^ @product.article.update( params.require(:article).permit(:content) ) )
    
    respond_to do |format|
      if @product.save
        #session[:return_to] = nil
        format.html { redirect_to :back, notice: '更新成功' }
      #format.html { redirect_to admin_product_cate_product_path(@product.product_cate_id, @product) }
      else
        #Rails.application.routes.recognize_path(request.referer)[:action]
        #p session[:return_to].parameterize.underscore.to_sym
        format.html { redirect_to :back, notice: @product.errors.full_messages }
      end      
    end
  end

  def change_status
    @product.status = (@product.status == "enable") ? "disable" : "enable"
    @product.save

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def destroy
    @product.destroy if @product
    
    respond_to do |format|
      format.html { redirect_to admin_product_cate_path(@product.product_cate_id) }
    end
  end

  # tab-1: basic
  def basic_info
    #session[:return_to] = 'basic_info'
  end
  # tab-2: product photo uploads
  def productphoto_upload
    
  end
  # tab-3: taste_attribute and upload radar chart
  def taste_attributes
    @taste_gallery_count = @product.galleries.select{ |v| v['type'] == "TasteAttributeGallery" }.count
  end
  # tab-4: peditor
  def free_paragraph
    
  end

  def create_product_attachment
      #deal with attachment
    if params[:filename].present? 
      display_name = params[:filename] 
    else 
      display_name = "#{@product.name}-PRODUCT-#{@product.galleries.count + 1}"
    end
    @latestAttach = ProductPhotoGallery.create(:attachment => params[:attachment], :attachable => @product, :file_name => display_name) if params[:attachment]
    
    respond_to do |format|
       format.html { redirect_to :back }
       #format.js {render :js => "window.location.href=window.location.href"}
    end
  end

  def create_taste_attachment
      #deal with attachment
    if params[:filename].present? 
      display_name = params[:filename] 
    else 
      display_name = "#{@product.name}-TASTE-#{@product.galleries.count + 1}"
    end
    @latestAttach = TasteAttributeGallery.create(:attachment => params[:attachment], :attachable => @product, :file_name => display_name) if params[:attachment]
    
    respond_to do |format|
      format.html { redirect_to :back }
      #format.js {render :js => "window.location.href=window.location.href"}
    end
  end

  private
    def set_product_with_cate
      @product = Product.includes(:product_cate).find_by_id(params[:id])
    end

    def set_product
      @product = Product.find_by_id(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :price_for_sale, :keypoints, :taste_attributes, :intro, :grindable, :unit,:kp_1, :kp_2, :kp_3, :kp_4, :kp_5,:gl_1, :gl_2, :gl_3, :gl_4, :gl_5,:taste_1, :taste_2, :taste_3, :taste_4, :taste_5, :taste_6)
    end

    def disable_product_when_edit
      @product.update_attributes({:status => "disable"})
    end

    def get_product_cate
      @product_cate = Product.find_by_id(params[:id])
    end
end
