#encoding: utf-8
class Admin::ServicesController < AdminController
  authorize_resource
  before_action :set_service, only: [:show, :edit, :update, :destroy, :servicephoto_upload, :create_service_attachment]

  def index

    @services = Service.includes(:galleries).all
    #@new_service = Service.new
  end
    
  def create

    @service = Service.create()
    #@service.article = Article.new

    respond_to do |format|
      if @service.save
        format.html { redirect_to edit_admin_service_path(@service), notice: 'service was successfully created.' }
      else
        format.html { redirect_to :back, notice: @service.errors.full_messages }
      end
    end

  end

  def show

  end

  # GET /admin/services/1/edit
  def edit
    @gallery_count = @service.galleries.select{ |v| v['type'] == "ServiceIconGallery" }.count
  end

  # tab-2: service photo uploads
  def servicephoto_upload
    
  end

  def create_service_attachment
      #deal with attachment
    if params[:filename].present? 
      display_name = params[:filename] 
    else 
      display_name = "#{@service.name}-service-#{@service.galleries.count + 1}"
    end
    @latestAttach = ServiceIconGallery.create(:attachment => params[:attachment], :attachable => @service, :file_name => display_name) if params[:attachment]
    
    respond_to do |format|
       format.js {render :js => "window.location.href=window.location.href"}
    end
  end
  
  # PATCH/PUT /admin/services/1
  # PATCH/PUT /admin/services/1.json
  def update

    if params[:filename].present? 
      display_name = params[:filename] 
    else 
      display_name = "#{@service.name}-service-#{@service.galleries.count + 1}"
    end
    @latestAttach = ServiceIconGallery.create(:attachment => params[:attachment], :attachable => @service, :file_name => display_name) if params[:attachment]

    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to admin_services_path(), notice: 'Service was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: :back }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/services/1
  # DELETE /admin/services/1.json
  def destroy

    @service.destroy
    respond_to do |format|
      format.html { redirect_to admin_services_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_service
    @service = Service.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def service_params
    params.require(:service).permit(:name, :attachment)
  end


end