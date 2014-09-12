class StaticsController < ApplicationController
  layout false , only: [:index]

  def index
    
    @index_sliders = Banner.includes(:galleries).where(type: 'IndexSlider', status: 'enable').limit(5)
    @jobs = Job.where(status: 'enable')
    @announcements = Announcement.includes(:galleries).for_index.limit(3)
    @talk = Talk.first
  
    active_product_ids = Product.where(status: 'enable')
    @recommended_products = Banner.where(type: 'SelectedProduct', status: 'enable', related_product_id: active_product_ids ).limit(3)
    
  end

  def show
  
    if params[ :page ].nil?
      redirect_to :index
    end
    
    respond_to do | format |
      format.html { render :template => 'statics/' + params[ :page ]  rescue redirect_to '/errors' }
    end
    
  end

end
