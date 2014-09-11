#encoding: utf-8
class Admin::CustomizedpagesController < AdminController
  authorize_resource
  layout :resolve_layout

  before_action :set_customizedpage, only: [:show, :edit, :update, :destroy, :customizedpagephoto_upload, :create_customizedpage_attachment]

  def index

    @customizedpages = Customizedpage.all
    #@new_customizedpage = Customizedpage.new
  end
    
  def create

    @customizedpage = Customizedpage.create()
    #@customizedpage.article = Article.new

    respond_to do |format|
      if @customizedpage.save
        format.html { redirect_to customizedpagephoto_upload_admin_customizedpage_path(@customizedpage), notice: 'customizedpage was successfully created.' }
      else
        format.html { redirect_to :back, notice: @customizedpage.errors.full_messages }
      end
    end

  end

  def show
    
  end

  # GET /admin/customizedpages/1/edit
  def edit

  end

  # tab-2: customizedpage photo uploads
  def customizedpagephoto_upload
    
  end

  def create_customizedpage_attachment
      #deal with attachment
    if params[:filename].present? 
      display_name = params[:filename] 
    else 
      display_name = "#{@customizedpage.title}-CUSTOMIZEDPAGE-#{@customizedpage.galleries.count + 1}"
    end
    @latestAttach = CustomizedpageCoverGallery.create(:attachment => params[:attachment], :attachable => @customizedpage, :file_name => display_name) if params[:attachment]
    
    respond_to do |format|
       format.js {render :js => "window.location.href=window.location.href"}
    end
  end
  
  # PATCH/PUT /admin/customizedpages/1
  # PATCH/PUT /admin/customizedpages/1.json
  def update

    respond_to do |format|
      if @customizedpage.update(customizedpage_params)
        format.html { redirect_to admin_customizedpage_path(@customizedpage), notice: 'Customizedpage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: :back }
        format.json { render json: @customizedpage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/customizedpages/1
  # DELETE /admin/customizedpages/1.json
  def destroy

    @customizedpage.destroy
    respond_to do |format|
      format.html { redirect_to admin_customizedpages_url }
      format.json { head :no_content }
    end
  end

  private

  def resolve_layout
    case action_name
    when "show"
      "customizedpage"
    else
      "admin"
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_customizedpage
    @customizedpage = Customizedpage.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def customizedpage_params
    params.require(:customizedpage).permit(:title, :subtitle, :html_content, :js_content, :ranking)
  end


end