#encoding: utf-8
class StoresController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  before_action :set_store, only: [:show]

  def index

    @countries = Country.all #use it when country selectable
    @cities = City.where("country_id = ?", Country.first.id)
    @districts = District.where("city_id = ?", City.first.id)
    #@stores = Store.order(sort_column + " " + sort_direction).page(params[:page])
    @services = Service.includes(:galleries).all
  end
  
  def search 
    #need to check params is valid
    if params[:look_for_services]
      # search services use IN condition
      #@stores = Store.includes(:services).where(country: params[:country], city: params[:city], district: params[:district],:services => {:id => params[:look_for_services]})
      
      # search services use AND condition
      match_ids = (StoreServiceShip.where(service_id: params[:look_for_services]).select('store_id').group('store_id').count).select {|k,v| v == params[:look_for_services].length }
      @stores = Store.where(id: match_ids.keys ,country: params[:country], city: params[:city], district: params[:district])
    else
      @stores = Store.where(country: params[:country], city: params[:city], district: params[:district])
    end

    respond_to do |format|
      format.js
    end    

  end

  def show
    #service

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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_store
    begin
      @store = Store.friendly.find(params[:id])

      if request.path != store_path(@store)
        return redirect_to @store, :status => :moved_permanently
      end
    rescue
      #flash[:notice] = "文章不存在"
      redirect_to announcements_path and return
    end

  end

  def sort_column
    Store.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end