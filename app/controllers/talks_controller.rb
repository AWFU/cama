#encoding: utf-8
class TalksController < ApplicationController
  
  before_action :set_talk, only: [:show]

  # tagged_with example
    
    # useful in talks
    #指定特別 tag分類
    #@stores = Store.tagged_with(["台中市","台北市"], on: :locations, any: true)
    #不指定特別 tag分類
    #@stores = Store.tagged_with(["台中市","台北市"], any: true)
    #其他屬性(can work with pre-defined scope and paginate)
    # :match_all => true , :exclude => true, 
    #You can also use :wild => true option along with :any or :exclude option. It will be looking for %awesome% and %cool% in SQL
    #find_related_skills

  def index
    tag = params[:tag].to_param
    allow = tag.in? Talk.includes(:galleries, :article).tag_counts_on(:camatalks).pluck(:name) unless tag.nil? || tag.empty?
    if params[:tag] && allow
      @talks = Talk.includes(:galleries, :article).tagged_with(tag, on: :camatalks, any: true).page(params[:page])
      @talks = @talks = Talk.includes(:galleries, :article).page(params[:page]) if @talks.count == 0
    else
      @talks = Talk.includes(:galleries, :article).page(params[:page])
      render :index
    end
    
    
  end

  def show

    @talks = Talk.includes(:galleries, :article)
    # Ugly but have to ... coz ranking 
    # Next talk and previous talk
    @talks.each_with_index do |talk, index|
      @index_of_record = index if talk == @talk
    end
    
    @talks[@index_of_record+1] ? @next_talk = @talks[@index_of_record+1] : @next_talk = nil
    if @index_of_record == 0
      @previous_talk = nil
    else
      @talks[@index_of_record-1] ? @previous_talk = @talks[@index_of_record-1] : @previous_talk = nil
    end

  end

  # def tag_cloud
  #   @tags = Talk.tag_counts_on(:camatalks)
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_talk
    begin
      @talk = Talk.find(params[:id])

      if request.path != talk_path(@talk)
        return redirect_to @talk, :status => :moved_permanently
      end
    rescue
      #flash[:notice] = "文章不存在"
      redirect_to talks_path and return
    end
  end

end