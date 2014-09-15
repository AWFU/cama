#encoding: utf-8
class StaticsController < ApplicationController
  layout false , only: [:index, :about]

  def index
    
    @index_sliders = Banner.includes(:galleries).where(type: 'IndexSlider', status: 'enable').limit(5)
    @jobs = Job.where(status: 'enable')
    @announcements = Announcement.includes(:galleries).for_index.limit(3)
    @announcement_length = 12

    @talk = Talk.first
  
    # 只顯示未下架產品
    active_product_ids = Product.where(status: 'enable')
    @recommended_products = Banner.where(type: 'SelectedProduct', status: 'enable', related_product_id: active_product_ids ).limit(3)
    

  end

  def about

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
