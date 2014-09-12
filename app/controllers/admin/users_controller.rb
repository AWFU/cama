class Admin::UsersController < AdminController
  authorize_resource
  def index
    @options = ["Email" ,"Name", "Address"]
    
    case( params[:type] )
      when "Email"
        @type = "email"
        
      when "Address"
        @type = "address"
        
      when "Name"
        @type = "username"
    end

    if @type
      @users = User.where("#{@type} LIKE ?", "%#{params[:value].gsub(/[\/ ]+/, '')}%" ).page(params[:page])
    else
      @users = User.page(params[:page])
    end

  end

  def show
    
    @user = User.find(params[:id])
    @orders = @user.orders.latest.page(params[:page]).per(10)

  end

  def search

    
    #need to check params is valid
    
      # search services use IN condition
      #@stores = Store.includes(:services).where(country: params[:country], city: params[:city], district: params[:district],:services => {:id => params[:look_for_services]})
      
      # search services use AND condition
      # match_ids = (StoreServiceShip.where(service_id: params[:look_for_services]).select('store_id').group('store_id').count).select {|k,v| v == params[:look_for_services].length }
      # @stores = Store.where(id: match_ids.keys ,country: params[:country], city: params[:city], district: params[:district])
    
      # @stores = Store.where(country: params[:country], city: params[:city], district: params[:district])
    

    # respond_to do |format|
    #   format.js
    # end    

  end

  def export
    @users = User.for_export
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv }
    end
  end


end