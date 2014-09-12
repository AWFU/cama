#encoding: utf-8
class Admin::TalksController < AdminController
  authorize_resource
  before_action :set_talk, only: [:show, :edit, :update, :destroy, :talkphoto_upload, :create_talk_attachment, :edit_tags, :update_tags]

  def index

    @talks = Talk.all.page(params[:page])

  end
    
  def create

    @talk = Talk.create()
    @talk.article = Article.new

    respond_to do |format|
      if @talk.save
        format.html { redirect_to edit_admin_talk_path(@talk), notice: 'talk was successfully created.' }
      else
        format.html { redirect_to :back, notice: @talk.errors.full_messages }
      end
    end

  end

  def show

  end

  # GET /admin/talks/1/edit
  def edit
    @gallery_count = @talk.galleries.select{ |v| v['type'] == "TalkCoverGallery" }.count
  end

  # tab-2: talk photo uploads
  def talkphoto_upload
    
  end

  # tab-3: tag
  def edit_tags
    
  end

  def update_tags
    @talk.camatalk_list = talk_params[:camatalk_list]
    
    respond_to do |format|
      if @talk.update(talk_params)
        format.html { redirect_to admin_talks_path, notice: 'Talk was successfully updated.' }
      else
        format.html { render action: :back }
      end
    end

  end

  def create_talk_attachment
      #deal with attachment
    if params[:filename].present? 
      display_name = params[:filename] 
    else 
      display_name = "#{@talk.title}-TALK-#{@talk.galleries.count + 1}"
    end
    @latestAttach = TalkCoverGallery.create(:attachment => params[:attachment], :attachable => @talk, :file_name => display_name) if params[:attachment]
    
    respond_to do |format|
       format.js {render :js => "window.location.href=window.location.href"}
    end
  end
  
  # PATCH/PUT /admin/talks/1
  # PATCH/PUT /admin/talks/1.json
  def update

    #deal with attachment
    if params[:filename].present? 
      display_name = params[:filename] 
    else 
      display_name = "#{@talk.title}-TALK-#{@talk.galleries.count + 1}"
    end
    @latestAttach = TalkCoverGallery.create(:attachment => params[:attachment], :attachable => @talk, :file_name => display_name) if params[:attachment]

    respond_to do |format|
      if @talk.update(talk_params) && params[ :article ].nil? ^ @talk.article.update( params.require(:article).permit(:content) )
        format.html { redirect_to edit_admin_talk_path(@talk), notice: 'Talk was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: :back }
        format.json { render json: @talk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/talks/1
  # DELETE /admin/talks/1.json
  def destroy

    @talk.destroy
    respond_to do |format|
      format.html { redirect_to admin_talks_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_talk
    @talk = Talk.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def talk_params
    params.require(:talk).permit(:title, :subtitle, :article_id, :ranking, :camatalk_list, :attachment)
  end


end