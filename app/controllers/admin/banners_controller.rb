#encoding: utf-8
class Admin::BannersController < AdminController
  authorize_resource
  before_action :set_admin_banner, only: [:show, :edit, :update, :destroy]
  #, :create_index_slider_attachment, :create_selected_product_attachment
  
  # GET /admin/banners
  # GET /admin/banners.json
  def index 
    @banner_type = banner_type

    if @banner_type == 'IndexSlider'
      @index_sliders = Banner.sliders #Banner.select{ |v| v['type'] == "IndexSlider" }  
    elsif @banner_type == 'SelectedProduct'
      @selected_products = Banner.products#Banner.select{ |v| v['type'] == "SelectedProduct" }  
    end  
    #@index_slide = IndexSlider.new
  end

  #new index slider
  def new
    @banner_type = banner_type

    if @banner_type == 'IndexSlider'
      @index_slider = IndexSlider.new
    elsif @banner_type == 'SelectedProduct'
      @selected_product = SelectedProduct.new
      @products = Product.all
    end  

  end

  def create
    @banner_type = banner_type

    if @banner_type == 'IndexSlider'
      @banner = IndexSlider.new(params.require(:index_slider).permit(:description))

      #deal with attachment
      if params[:filename].present?
        display_name = params[:filename]
      else
        display_name = "#{@banner.title}-BANNER-#{@banner.galleries.count + 1}"
      end

      respond_to do |format|
        if @banner.save
          @latestAttach = IndexSliderGallery.create(:attachment => params[:attachment], :attachable => @banner, :file_name => display_name) if params[:attachment]
          flash[:notice] = "更新成功"
          format.html { redirect_to admin_index_sliders_path() }
          #format.js {render :js => "window.location.href=window.location.href;"}
        else
          format.html { redirect_to :back , notice: @banner.errors.full_messages }
        end
      end

    elsif @banner_type == 'SelectedProduct'
      @banner = SelectedProduct.new(params.require(:selected_product).permit(:related_product_id,:description, :status))

      #deal with attachment
      if params[:filename].present?
        display_name = params[:filename]
      else
        display_name = "#{@banner.title}-BANNER-#{@banner.galleries.count + 1}"
      end

      respond_to do |format|
        if @banner.save
          @latestAttach = SelectedProduct.create(:attachment => params[:attachment], :attachable => @banner, :file_name => display_name) if params[:attachment]
          flash[:notice] = "更新成功"
          format.html { redirect_to admin_selected_products_path() }
          #format.js {render :js => "window.location.href=window.location.href;"}
        else
          format.html { redirect_to :back, notice: @banner.errors.full_messages }
        end
      end      
    end      
  end

  # GET /admin/banners/1
  # GET /admin/banners/1.json
  def show
  end

  # GET /admin/banners/1/edit
  def edit
    # selected product
    @products = Product.all
  end

  # PATCH/PUT /admin/banners/1
  # PATCH/PUT /admin/banners/1.json
  def update
    @banner = Banner.find(params[:id])

    
    # thought-1: depends on type
    @banner.update ( admin_banner_params )
    

    respond_to do |format|
      #if @banner.update(admin_banner_params)
      if @banner.save
        @banner_type = banner_type

        if @banner_type == 'IndexSlider'
          format.html { redirect_to admin_index_sliders_path, notice: 'Successfully updated.' }
          format.json { head :no_content }
        elsif @banner_type == 'SelectedProduct'
          format.html { redirect_to admin_selected_products_path, notice: 'Successfully updated.' }
          format.json { head :no_content }
        end
      else
        format.html { render action: :back }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/banners/1
  # DELETE /admin/banners/1.json
  def destroy
    @banner.destroy
    respond_to do |format|
      flash[:notice] = "刪除成功"
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_banner
    @banner = Banner.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_banner_params
    #params.require(:banner).permit(:title, :description)
    if banner_type == 'IndexSlider'
      params.require(:index_slider).permit(:title, :description)
    elsif banner_type == 'SelectedProduct'
      params.require(:selected_product).permit(:title, :description, :related_product_id, :status)
    end
      
  end

  def banner_types
    ['IndexSlider', 'SelectedProduct']
  end

  def banner_type
    if !params[:type].nil?
      params[:type] if params[:type].in? banner_types
    else
      @banner.type if @banner.type.in? banner_types
    end
    
  end

end
