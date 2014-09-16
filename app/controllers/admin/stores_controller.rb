#encoding: utf-8
class Admin::StoresController < AdminController
  authorize_resource
  ###################
  # ref count not implement yet
  ###################
  helper_method :sort_column, :sort_direction
  
  before_action :set_store, only: [:show, :edit, :update, :destroy, :storephoto_upload, :create_store_attachment]

  def index
    # tagged_with example
    
    #指定特別 tag分類
    #@stores = Store.tagged_with(["台中市","台北市"], on: :locations, any: true)
    #不指定特別 tag分類
    #@stores = Store.tagged_with(["台中市","台北市"], any: true)
    #其他屬性(can work with pre-defined scope and paginate)
    # :match_all => true , :exclude => true, 
    #You can also use :wild => true option along with :any or :exclude option. It will be looking for %awesome% and %cool% in SQL
    #find_related_skills

    #@stores = Store.all

    @stores = Store.order(sort_column + " " + sort_direction).page(params[:page])
    #@store = Store.new
  end

  def new
    @store = Store.new

    @countries = Country.all #use it when country selectable
    @cities = City.where("country_id = ?", Country.first.id)
    @districts = District.where("city_id = ?", City.first.id)

  end
    
  def create

    @store = Store.new(store_params)
    #let location as default tagged
    @store.location_list.add(Country.find(@store.country).name) unless @store.country.empty?
    @store.location_list.add(City.find(@store.city).name) unless @store.city.empty?
    @store.location_list.add(District.find(@store.district).name) unless @store.district.empty?

    respond_to do |format|
      if @store.save
        format.html { redirect_to admin_stores_path(), notice: 'store was successfully created.' }
      else
        format.html { redirect_to :back, notice: @store.errors.full_messages }
      end
    end

  end

  def show

  end

  # GET /admin/stores/1/edit
  def edit
    
    @cities = City.where("country_id = ?", @store.country)
    @districts = District.where("city_id = ?", @store.city)
    #get all tag by context
    #@all_tag_with_context = ActsAsTaggableOn::Tagging.where(:context => 'services').joins(:tag).select('DISTINCT tags.name').map{ |x| x.name}

  end

  # tab-2: store photo uploads
  def storephoto_upload
    @gallery_count = @store.galleries.select{ |v| v['type'] == "StorePhotoGallery" }.count
  end

  def create_store_attachment
      #deal with attachment
    if params[:filename].present? 
      display_name = params[:filename] 
    else 
      display_name = "#{@store.name}-STORE-#{@store.galleries.count + 1}"
    end
    @latestAttach = StorePhotoGallery.create(:attachment => params[:attachment], :attachable => @store, :file_name => display_name) if params[:attachment]
    
    respond_to do |format|
       format.html { redirect_to storephoto_upload_admin_store_path(@store), notice: 'store photo was successfully created.' }
       #format.js {render :js => "window.location.href=window.location.href"}
    end
  end

  def fetch_from_country
    @cities = City.where("country_id = ?", params[:country_id])
    @districts = District.where("city_id = ?", @cities.first.id)
    respond_to do |format|
      format.js
    end    
  end

  def fetch_from_city 
    @districts = District.where("city_id = ?", params[:city_id])
    respond_to do |format|
      format.js
    end    
  end


  # PATCH/PUT /admin/stores/1
  # PATCH/PUT /admin/stores/1.json
  def update

    @store.location_list = ""
    #p store_params[:location_list]
    
    @store.location_list.add(Country.find(@store.country).name) unless @store.country.empty?
    @store.location_list.add(City.find(@store.city).name) unless @store.city.empty?
    @store.location_list.add(District.find(@store.district).name) unless @store.district.empty?

    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to :back, notice: '更新成功' }
        format.json { head :no_content }
      else
        format.html { render action: :back }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/stores/1
  # DELETE /admin/stores/1.json
  def destroy

    #也要處理相關tags的刪除？

    @store.destroy
    respond_to do |format|
      format.html { redirect_to admin_stores_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_store
    @store = Store.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def store_params
    params.require(:store).permit(:name, :address, :intro, :phone, :address, :country, :city, :district, :ophour, :latlng, :location_list , :service_list )
  end

  def sort_column
    Store.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end